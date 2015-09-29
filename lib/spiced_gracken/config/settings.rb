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
          to: :instance

        def instance
          @instance ||= new
        end
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
