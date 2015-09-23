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
    def add(address, last_alias)

      unless server_exists?(address)
        entry = {
          'last_alias' => last_alias,
          'address' => address
        }
        @settings['servers'] << entry
        @active_servers << entry
        save
        puts "added #{address} to server list!".colorize(:green)
      else
        puts "#{address} already exists and will not be added"
      end
    end

    def remove_by(args)
      last_alias = args['last_alias']
      address = args['address']

      new_servers = []

      servers.each do |entry|
        match = (
          last_alias && entry['last_alias'] == last_alias ||
          address && entry['address'] == address
        )

        if match
          puts "removed #{entry['last_alias']}@#{entry['address']}"
        else
          new_servers << entry
        end
      end

      @settings['servers'] = new_servers
      save
    end

    def remove(field, value)
      remove_by(field => value)
    end

    def find_by(last_alias: nil, address: nil)
      servers.each do |entry|
        found = (
          (last_alias && entry['last_alias'] == last_alias) ||
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
      puts @settings['servers'].inspect
    end
  end
end
