module SpicedGracken
  module Config
    class ServerList < HashFile
      FILENAME = 'serverlist.json'
      DEFAULT_SETTINGS = { 'servers' => [] }

      attr_accessor :_active_servers

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

      # @param [Entry] entry
      def add(entry)

        unless server_exists?(entry.address)
          _hash['servers'] << entry.as_json
          save
          puts "added #{entry.address} to server list!".colorize(:green)
        else
          puts "#{entry.address} already exists and will not be added"
        end
      end

      def remove_by(args)
        alias_name = args['alias']
        address = args['address']


        entry = find_by(alias_name: alias_name, address: address)

        if entry
          self['servers'].remove(entry)
        end

        save
      end

      def remove(field, value)
        remove_by(field => value)
      end

      def find_by(alias_name: nil, address: nil)
        servers.each do |entry|
          found = (
            (alias_name && entry['alias'] == alias_name) ||
            (address && entry['address'] == address) ||
            (uid && entry['uid'] == uid)
          )

          return entry if found
        end

        nil
      end

      def server_exists?(address)
        !!find_by(address: address)
      end

      def uid_exists?(uid)
        !!find_by(uid: uid)
      end

      def display_addresses
        puts servers.inspect
      end
    end
  end
end
