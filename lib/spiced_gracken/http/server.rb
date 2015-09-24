module SpicedGracken
  module Http
    class Server
      attr_accessor :server

      # instantiate!
      def initialize(port: '')
        puts "listening on #{port}...".colorize(:green)
        @server = TCPServer.new(port)

        loop do
          # use a seprate thread, acception multiple incoming connections
          Thread.start(@server.accept) do |connection|
            begin
              while (input = connection.gets)
                data = JSON.parse(input)

                type = data['type']
                message = nil
                # figure out what to do
                case type
                when Message::CHAT
                  message = Message::Chat.new
                  message.payload = data
                when Message::CONNECTION
                  message = Message::Connection.new
                  message.payload = data
                when Message::WHISPER
                  message = Message::Whisper.new
                  message.payload = data
                when Message::DISCONNECTION
                  message = Message::Disconnection.new
                  message.payload = data
                when Message::Authorization
                  puts 'not yet implemented...'
                else
                  puts 'message recieved and not recognized...'.colorize(:red)
                  puts input
                end

                message.display
              end
            rescue => e
              puts e.message.colorize(:red)
              puts e.backtrace.join("\n").colorize(:red)

              puts input.inspect
            end
          end
        end
      end

      def address
        "#{server.address}:#{server.port}"
      end
    end
  end
end
