module SpicedGracken
  module Http
    class Server
      attr_accessor :server

      # instantiate!
      def initialize(port: '')
        SpicedGracken.display.add_line("listening on #{port}...".colorize(:green))
        @server = TCPServer.new(port)

        loop do
          # use a seprate thread, acception multiple incoming connections
          Thread.start(@server.accept) do |connection|
            begin
              while (input = connection.gets)
                data = JSON.parse(input)

                update_sender_info(data)


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
                when Message::PING
                  message = Message::Ping.new
                  message.payload = data
                  # immediately respond
                  message.respond
                when Message::PING_REPLY
                  message = Message::PingReply.new
                  message.payload = data
                when Message::Authorization, Message::SERVER_LIST, Message::SERVER_LIST_HASH, Message::SERVER_LIST_DIFF
                  puts input
                  puts 'not yet implemented...'.colorize(:red)
                else
                  puts 'message recieved and not recognized...'.colorize(:red)
                  puts input
                end

                SpicedGracken.display.add_line(message.display)
              end
            rescue => e
              puts e.message.colorize(:red)
              puts e.backtrace.join("\n").colorize(:red)

              puts input.inspect
            end
          end
        end
      end

      def update_sender_info(data)
        sender = data['sender']

        SpicedGracken.active_server_list.update(
          sender['uid'],
          address: sender['location'],
          alias_name: sender['name']
        )
      end

      def address
        "#{server.address}:#{server.port}"
      end
    end
  end
end
