module SpicedGracken
  class CLI
    class Input

      attr_accessor :_input, :_cli, :_settings

      class << self
        def create(input, cli: nil, settings: nil)
          klass =
            if is_command(input)
              CLI::Command
            else
              CLI::Input
            end

          klass.new(input, cli: cli, settings: settings)
        end

        def is_command(input)
          input[0,1] == "/"
        end
      end

      def initialize(input, cli: nil, settings: nil)
        self._input = input.chomp
        self._cli = cli
        self._settings = settings
      end

      def handle
        if _cli.client and !_cli.client.socket.closed?
          m = Message::Chat.new(
            message: _input,
            name_of_sender: _settings[:alias]
          )
          m.display
          data = m.render

          _cli.client.send(message: data)
          print "\n"
        else
          puts "start listening, and then start a chat".colorize(:yellow)
        end
      end
    end
  end
end
