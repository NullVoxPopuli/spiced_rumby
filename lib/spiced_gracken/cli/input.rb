module SpicedGracken
  class CLI
    class Input
      WHISPER = '@'
      COMMAND = '/'
      attr_accessor :_input, :_cli, :_settings

      class << self
        def create(input, cli: nil, settings: nil)
          klass =
            if is_command(input)
              CLI::Command
            elsif is_whisper?(input)
              CLI::Whisper
            else
              CLI::Input
            end

          klass.new(input, cli: cli, settings: settings)
        end

        def is_command(input)
          input[0,1] == COMMAND
        end

        def is_whisper?(input)
          input[0,1] == WHISPER
        end
      end

      def initialize(input, cli: nil, settings: nil)
        self._input = input.chomp
        self._cli = cli
        self._settings = settings
      end

      def handle
        servers = SpicedGracken.server_list.servers
        if !servers.empty?
        # if _cli.client and !_cli.client.socket.closed?
          m = Message::Chat.new(
            message: _input,
            name_of_sender: _settings[:alias],
            location: _cli.server_address
          )
          m.display
          data = m.render

          # if sending to all, iterate thorugh list of
          # servers, and send to each one
          servers.each do |entry|
            Http::Client.send_to_and_close(
              address: entry['address'],
              payload: data
            )
          end
        else
          puts "you have no servers".colorize(:yellow)
        end
      end
    end
  end
end
