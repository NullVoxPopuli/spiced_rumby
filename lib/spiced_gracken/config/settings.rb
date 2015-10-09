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
          :private_key, :generate_keys, :share,
          to: :instance

        def instance
          @instance ||= new
        end
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

      def public_key
        self['publicKey']
      end

      def private_key
        self['privatKey']
      end

      def generate_keys
        public_key, private_key = Encryption::Keypair.generate(2048)
        self['publicKey'] = public_key.to_s
        self['privateKey'] = private_key.to_s
        Display.success 'new keys generated'
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
