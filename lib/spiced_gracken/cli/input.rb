module SpicedGracken
  class CLI
    class Input
      WHISPER = '@'
      COMMAND = '/'
      attr_accessor :_input

      class << self
        def create(input)
          klass =
            if is_command(input)
              CLI::Command
            elsif is_whisper?(input)
              CLI::Whisper
            else
              # TODO: maybe change this to a chat command?
              CLI::Input
            end

          klass.new(input)
        end

        def is_command(input)
          input[0, 1] == COMMAND
        end

        def is_whisper?(input)
          input[0, 1] == WHISPER
        end
      end

      def initialize(input)
        self._input = input.chomp
      end

      def handle
        servers = ActiveServers.all
        if !servers.empty?
          m = Message::Chat.new(
            message: _input
          )

          Display.chat m.display
          data = m.render

          # if sending to all, iterate thorugh list of
          # servers, and send to each one
          # TODO: do this async so that one server doesn't block
          # the rest of the servers from receiving the messages
          servers.each do |entry|
            Thread.new(entry, data) do |entry, data|
              Http::Client.send_to_and_close(
                address: entry.address,
                payload: data,
                encrypt_with: entry.public_key
              )
            end
          end
        else
          Display.warning 'you have no servers'
        end
      end
    end
  end
end
