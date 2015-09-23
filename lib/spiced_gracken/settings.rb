module SpicedGracken
  class Settings
    FILENAME = "settings.json"

    attr_accessor :settings

    DEFAULT_SETTINGS = {
      "alias" => "alias",
      "port" => "2008",
      "ip" => "localhost"
    }

    def initialize
      # check if the file exists
      exists? ? load : save
      
      @settings ||= DEFAULT_SETTINGS
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

    def filename
      FILENAME
    end
  end
end
