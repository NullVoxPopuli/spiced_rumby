module SpicedGracken
  module Config
    class ServerList < HashFile
      FILENAME = 'serverlist.json'
      DEFAULT_SETTINGS = { 'servers' => [] }

      class << self
        delegate :as_entries, :servers, :save,
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

      def clear!
        @entries = nil
        self._hash ||= {}
        self._hash.clear
        self._hash = { 'servers' => [] }
      end

      def servers
        self['servers'] ||= []
      end

      def servers=(new_list)
        self['servers'] = new_list
      end

      def as_entries
        if @entries.nil?
          @entries = []
          servers.each do |s|
            entry = Entry.new(
              address: s['address'],
              alias_name: s['alias'],
              uid: s['uid'],
              public_key: s['publicKey']
            )
            next unless entry.valid?

            @entries << entry
          end
        end

        @entries
      end
    end
  end
end
