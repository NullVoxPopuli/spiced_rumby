module SpicedGracken
  module Display
    module Bash
      class UI < MeshChat::Display::Base
        def start
          puts "\n"
          alert Help.welcome
          puts "\n"
          puts "\n"
          yield if block_given?
          MeshChat::CLI.listen_for_commands
        end

        # TODO: find a more elegant way to handle color
        def add_line(line)
          puts line
        end

        def info(msg)
          puts msg.colorize(:light_black)
        end

        def warning(msg)
          puts msg.colorize(:yellow)
        end

        def alert(msg)
          puts msg.colorize(:red)
        end

        def success(msg)
          puts msg.colorize(:green)
        end

        def chat(msg)
          words = msg.split(' ')
          time = words[0..1]
          name = words[2]
          message = words[3..words.length]

          print (time.join(' ') + ' ').colorize(:light_magenta)
          print (name + ' ').colorize(:cyan)
          print message.join(' ') + "\n"
        end

        def whisper(msg)
          words = msg.split(' ')
          time = words[0..1]
          name = words[2]
          message = words[3..words.length]

          print (time.join(' ') + ' ').colorize(:magenta)
          print (name + ' ').colorize(:light_black)
          print message.join(' ') + "\n"
        end
      end
    end
  end
end
