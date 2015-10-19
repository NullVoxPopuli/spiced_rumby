module SpicedGracken
  module Config
    class Settings < HashFile
      FILENAME = 'settings.json'

      DEFAULT_SETTINGS = {
        'alias' => 'alias',
        'port' => '2008',
        'ip' => 'localhost',
        'uid' => '1',
        'publicKey' => 'replace this'
      }

      class << self
        delegate :valid?, :errors,
          :[], :[]=, :display, :as_hash, :save, :set,
          :location, :identity, :keys_exist?, :public_key,
          :private_key, :generate_keys, :share, :key_pair,
          :uid_exists?, :generate_uid, :debug?,
          to: :instance

        def instance
          @instance ||= new
        end
      end

      def debug?
        ['true', '1', 'yes', 'y', 't'].include?(self['debug'].try(:downcase))
      end

      def share
        data = {
          'alias' => me = self['alias'],
          'location' => location,
          'uid' => self['uid'],
          'publicKey' => public_key
        }.to_json

        filename = "#{me}.json"
        File.open(filename, 'w'){ |f| f.syswrite(data) }
        Display.info "#{filename} written..."
      end

      def keys_exist?
        public_key.present? && private_key.present?
      end

      def uid_exists?
        self['uid'].present?
      end

      def public_key
        self['publicKey']
      end

      def private_key
        self['privatKey']
      end

      # generates 32 bytes
      def generate_uid
        self['uid'] = SecureRandom.hex(32)
        Display.success 'new uid set'
      end

      def generate_keys
        @key_pair = OpenSSL::PKey::RSA.new(2048)
        self['publicKey'] = @key_pair.public_key.to_pem
        self['privateKey'] = @key_pair.to_pem
        Display.success 'new keys generated'
      end

      def key_pair
        if !@key_pair && keys_exist?
          @key_pair = OpenSSL::PKey::RSA.new(self['privateKey'] + self['publicKey'])
        end
        @key_pair
      end

      def identity
        "#{self['alias']}@#{location}##{self['uid']}"
      end

      def location
        "#{self['ip']}:#{self['port']}"
      end

      def initialize
        @default_settings = DEFAULT_SETTINGS
        @filename = FILENAME
        super
      end

      def valid?
        errors.empty?
      end

      def errors
        messages = []
        messages << 'must have an alias' if !self['alias']
        messages << 'must have ip set' if !self['ip']
        messages << 'must have port set' if !self['port']
        messages << 'must have uid set' if !self['uid']
        messages
      end
    end
  end
end
