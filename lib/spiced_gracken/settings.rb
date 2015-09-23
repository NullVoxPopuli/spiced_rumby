module SpicedGracken
  class Settings < HashFile
    FILENAME = "settings.json"

    DEFAULT_SETTINGS = {
      "alias" => "alias",
      "port" => "2008",
      "ip" => "localhost"
    }

    def initialize
      @default_settings = DEFAULT_SETTINGS
      @filename = FILENAME
      super
    end


  end
end
