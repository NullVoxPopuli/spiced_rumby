module SpicedGracken
  class Settings
    FILENAME = "settings.json"

    attr_accessor :settings

    DEFAULT_SETTINGS = {
      "alias" => "alias",
      "port" => "2008",
      "default_host" => "localhost"
    }

    def initialize
      @settings = DEFAULT_SETTINGS
      # check if the file exists
      exists? ? load : save
    end

    def [](key)
      @settings[key.to_s]
    end

    def load
      f = File.read(FILENAME)
      begin
        @settings.merge!(JSON.parse(f))
      rescue Exception => e
        ap e.message
        ap "writing defaults..."
        save
      end
    end

    def display
      ap @settings
    end

    def as_hash
      @settings
    end

    def save
      # backup
      File.rename(FILENAME, FILENAME + ".bak") if exists = exists?
      # write
      File.open( FILENAME, "w" ){ |f| f.syswrite(@settings.to_json); f.close }
      # remove backup
      File.delete( FILENAME + ".bak") if exists
    end

    def set(key, with: value)
      @settings[key] = with
      save
      puts "#{key} set to #{with}\n"
    end

    def exists?
      File.exist?(FILENAME)
    end
  end
end
