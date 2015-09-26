module SpicedGracken
  class CLI
    class Input
      WHISPER = '@'
      COMMAND = '/'
      attr_accessor :_input, :_cli

      class << self
        def create(input, cli: nil)
          klass =
            if is_command(input)
              CLI::Command
            elsif is_whisper?(input)
              CLI::Whisper
            else
              # TODO: maybe change this to a chat command?
              CLI::Input
            end

          klass.new(input, cli: cli)
        end

        def is_command(input)
          input[0, 1] == COMMAND
        end

        def is_whisper?(input)
          input[0, 1] == WHISPER
        end
      end

      def initialize(input, cli: nil)
        self._input = input.chomp
        self._cli = cli
      end

      def handle
        servers = SpicedGracken.active_server_list.all
        if !servers.empty?
          # if _cli.client and !_cli.client.socket.closed?
          m = Message::Chat.new(
            message: _input,
            name_of_sender: SpicedGracken.settings[:alias],
            location: _cli.server_address,
            uid: SpicedGracken.settings[:uid]
          )
          # SpicedGracken.display.add_line(m.display)

          # TODO: replace with method_missing?
          # maybe pass the method object instead?
          SpicedGracken.ui.debug("server:: #{m.class.name}")
          case m.class.name
          when SpicedGracken::Message::Chat.name
            SpicedGracken.ui.chat m.display
          when SpicedGracken::Message::Whisper.name
            SpicedGracken.ui.whisper m.display
          else
            SpicedGracken.ui.add_line m.display
          end
          data = m.render

          # if sending to all, iterate thorugh list of
          # servers, and send to each one
          # TODO: do this async so that one server doesn't block
          # the rest of the servers from receiving the messages
          servers.each do |entry|
            Thread.new(entry, data) do |entry, data|
              Http::Client.send_to_and_close(
                address: entry.address,
                payload: data
              )
            end
          end
        else
          SpicedGracken.ui.warning(
            'you have no servers'
          )
        end
      end
    end
  end
end
