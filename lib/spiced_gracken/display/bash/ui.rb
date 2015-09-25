module SpicedGracken
  module Display
    module Bash
      class UI < Display::Base
        def start
          puts Help.welcome
          SpicedGracken.cli.listen_for_commands
        end

        # TODO: find a more elegant way to handle color
        def add_line(line)
          puts line
        end

        def message_from_gracken(msg)
          puts msg.colorize(:light_black)
        end
      end
    end
  end
end
