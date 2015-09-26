module SpicedGracken
  module Config
    class HashFile
      attr_accessor :_hash

      DEFAULT_SETTINGS = {}

      def initialize
        self._hash = default_settings
        exists? ? load : save
      end

      def [](key)
        _hash[key.to_s]
      end

      def []=(key, value)
        _hash[key.to_s] = value
      end

      def load
        f = File.read(filename)
        begin
          self._hash = JSON.parse(f)
        rescue Exception => e
          puts e.message.colorize(:red)
          self._hash = default_settings
          puts 'writing defaults...'
          save
        end
      end

      def display
        puts _hash.inspect
      end

      def as_hash
        _hash
      end

      def save
        # backup
        exists = exists?
        File.rename(filename, filename + '.bak') if exists
        # write
        File.open(filename, 'w') { |f| f.syswrite(_hash.to_json) }
        # remove backup
        File.delete(filename + '.bak') if exists
      end

      def set(key, with: value)
        self[key] = with
        save
        puts "#{key} set to #{with}\n"
      end

      def exists?
        File.exist?(filename)
      end

      def filename
        return @filename if @filename
        fail 'filename must be set'
      end

      def default_settings
        @default_settings ? @default_settings : DEFAULT_SETTINGS
      end
    end
  end
end
