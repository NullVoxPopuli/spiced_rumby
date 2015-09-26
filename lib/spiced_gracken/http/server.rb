module SpicedGracken
  module Http
    class Server
      attr_accessor :server

      # instantiate!
      def initialize(port: '')
        SpicedGracken.display.success "listening on #{port}..."
        @server = TCPServer.new(port)

        loop do
          # use a seprate thread, acception multiple incoming connections
          Thread.start(@server.accept) do |connection|
            begin
              while (input = connection.gets)
                SpicedGracken.ui.debug 'server received message:'
                SpicedGracken.ui.debug input

                data = JSON.parse(input)

                update_sender_info(data)

                type = data['type']
                message = nil
                # figure out what to do
                # TODO: replace with send
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
                  SpicedGracken.ui.alert 'not yet implemented...'
                else
                  SpicedGracken.ui.alert 'message recieved and not recognized...'
                end

                # TODO: replace with method_missing?
                # maybe pass the method object instead?
                # maybe extract to a render_disributer? idk.
                SpicedGracken.ui.debug("server:: #{message.class.name}")
                case message.class.name
                when SpicedGracken::Message::Chat.name
                  SpicedGracken.ui.chat message.display
                when SpicedGracken::Message::Whisper.name
                  SpicedGracken.ui.whisper message.display
                else
                  SpicedGracken.ui.add_line message.display
                end
              end
            rescue => e
              # rescue here so that the server doesn't stop listening
              SpicedGracken.ui.alert e.message
              SpicedGracken.ui.fatal e.message
              SpicedGracken.ui.fatal e.backtrace.join("\n")
            end
          end
        end
      rescue => e
        SpicedGracken.ui.alert e.message
        SpicedGracken.ui.fatal e.message
        SpicedGracken.ui.fatal e.backtrace.join("\n")
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
