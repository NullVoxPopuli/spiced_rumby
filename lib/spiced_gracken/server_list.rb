module SpicedGracken
  class ServerList < HashFile
    FILENAME = "serverlist.json"
    DEFAULT_SETTINGS = { 'servers' => [] }

    attr_accessor :_active_servers

    def initialize
      @default_settings = DEFAULT_SETTINGS
      @filename = FILENAME
      super

      @active_servers = self['servers']
    end

    def clear!
      self._hash ||= {}
      self._active_servers ||= []
      self._hash.clear
      self._active_servers.clear
      self._hash = { 'servers' => [] }
      self._active_servers = []
    end

    def servers
      active_servers
    end

    def active_servers
      _active_servers || []
    end

    def inactive!(address)

      new_servers = []

      servers.each do |entry|
        match = address && entry['address'] == address
        new_servers << entry unless match
      end

      self._active_servers = new_servers
    end

    # @param [string] address ip:port
    def add(address, alias_name = '')

      unless server_exists?(address)
        entry = {
          'alias' => alias_name,
          'address' => address
        }
        _hash['servers'] << entry
        _active_servers << entry
        save
        puts "added #{address} to server list!".colorize(:green)
      else
        puts "#{address} already exists and will not be added"
      end
    end

    def remove_by(args)
      alias_name = args['alias']
      address = args['address']

      new_servers = []

      servers.each do |entry|
        match = (
          alias_name && entry['alias'] == alias_name ||
          address && entry['address'] == address
        )

        if match
          puts "removed #{entry['alias']}@#{entry['address']}"
        else
          new_servers << entry
        end
      end

      _hash['servers'] = new_servers
      save
    end

    def remove(field, value)
      remove_by(field => value)
    end

    def find_by(alias_name: nil, address: nil)
      servers.each do |entry|
        found = (
          (alias_name && entry['alias'] == alias_name) ||
          (address && entry['address'] == address)
        )

        return entry if found
      end

      nil
    end

    def server_exists?(address)
      !!find_by(address: address)
    end

    def display_addresses
      puts servers.inspect
    end
  end
end
