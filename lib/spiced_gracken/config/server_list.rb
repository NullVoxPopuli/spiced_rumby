module SpicedGracken
  module Config
    class ServerList < HashFile
      FILENAME = 'serverlist.json'
      DEFAULT_SETTINGS = { 'servers' => [] }

      def initialize
        @default_settings = DEFAULT_SETTINGS
        @filename = FILENAME
        super
      end

      def clear!
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
        unless @entries
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
