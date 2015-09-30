module SpicedGracken
  module Models
    class Entry < ActiveRecord::Base

      validates :alias_name, :address, presence: true
      validates :uid, presence: true, uniqueness: true

      # ipv4 with port
      validates_format_of :address, with: /((?:(?:^|\.)(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){4})(:\d*)?/

      class << self
        def sha_preimage
          all.map(&:public_key).sort.join(',')
        end

        def as_sha512
          digest = Digest::SHA512.new
          digest.hexdigest sha_preimage
        end

        def from_json(json)
          new(
            alias_name: json['alias'],
            address: json['address'],
            uid: json['uid'],
            public_key: json['publicKey']
          )
        end

      end

      def as_json
        {
          'alias' => alias_name,
          'address' => address,
          'uid' => uid,
          'publicKey' => public_key
        }
      end
    end
  end
end
