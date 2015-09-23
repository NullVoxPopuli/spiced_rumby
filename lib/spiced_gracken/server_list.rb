module SpicedGracken
  class ServerList
    FILENAME = "serverlist.json"
    DEFAULT_SETTINGS = { 'servers' => [] }

    def initialize
      @settings = DEFAULT_SETTINGS
      # check if the file exists
      exists? ? load : save

      @active_servers = @settings['servers']
    end

    def [](key)
      @settings[key.to_s]
    end

    def load
      f = File.read(filename)
      begin
        @settings.merge!(JSON.parse(f))
      rescue Exception => e
        puts e.message.colorize(:red)
        puts "writing defaults..."
        save
      end
    end

    def display
      puts @settings.inspect
    end

    def as_hash
      @settings
    end

    def servers
      active_servers
    end

    def active_servers
      @active_servers || []
    end

    def inactive!(address)

      new_servers = []

      servers.each do |entry|
        match = address && entry['address'] == address
        new_servers << entry unless match
      end

      @active_servers = new_servers
    end

    def load
      f = File.read(filename)
      begin
        @settings.merge!(JSON.parse(f))
      rescue Exception => e
        puts e.message.colorize(:red)
        puts "writing defaults..."
        save
      end
    end

    def save
      # backup
      File.rename(filename, filename + ".bak") if exists = exists?
      # write
      File.open(filename, "w" ){ |f| f.syswrite(@settings.to_json); f.close }
      # remove backup
      File.delete(filename + ".bak") if exists
    end

    def set(key, with: value)
      @settings[key] = with
      save
      puts "#{key} set to #{with}\n"
    end

    def exists?
      File.exist?(filename)
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

    def filename
      FILENAME
    end

    def display_addresses
      puts @settings['servers'].inspect
    end
  end
end
