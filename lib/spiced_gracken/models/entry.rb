module SpicedGracken
  module Models
    class Entry < ActiveRecord::Base
      IPV4_WITH_PORT = /((?:(?:^|\.)(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){4})(:\d*)?/
      # http://rubular.com/r/WYT09ptct3
      DOMAIN_WITH_PORT = /(https?:\/\/)?([\da-z\.-]+)\.?([a-z\.]{2,6})([\/\w \.-]*)*[^\/](:\d*)?/

      validates :alias_name, :location, presence: true
      validates :uid, presence: true, uniqueness: true

      # ipv4 with port
      validates_format_of :location, with: ->(e){
        e.location.include?('.') || e.location.include?('localhost') ?
          DOMAIN_WITH_PORT :
          IPV4_WITH_PORT
      }

      class << self
        def sha_preimage
          all.map(&:public_key).sort.join(',')
        end

        def as_sha512
          digest = Digest::SHA512.new
          digest.hexdigest sha_preimage
        end

        def as_json
          all.map(&:as_json)
        end

        def from_json(json)
          new(
            alias_name: json['alias'],
            location: json['location'],
            uid: json['uid'],
            public_key: json['publicKey']
          )
        end

        def public_key_from_uid(uid)
          find_by_uid(uid).try(:public_key)
        end

        # @param [Array] theirs array of hashes representing node entries
        # @return [Array<-,+>] nodes only we have, and nodes only they have
        def diff(theirs)
          ours = as_json
          we_only_have = ours - theirs
          they_only_have = theirs - ours

          [we_only_have, they_only_have]
        end

        def import_from_file(filename)
          begin
            f = File.read(filename)
            hash = JSON.parse(f)
            n = from_json(hash)
            n.save
            n
          rescue => e
            Display.alert e.message
          end
        end
      end

      def ==(other)
        result = false

        if other.is_a?(Hash)
          result = as_json.values_at(*other.keys) == other.values
        end

        result || super
      end

      def as_json
        {
          'alias' => alias_name,
          'location' => location,
          'uid' => uid,
          'publicKey' => public_key
        }
      end
    end
  end
end
