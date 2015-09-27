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
                processes_message(data)
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

      def processes_message(data)
        type = data['type']
        klass = Message::TYPES[type]

        unless klass
          SpicedGracken.ui.alert 'message recieved and not recognized...'
          return
        end

        message = klass.new(payload: data)
        SpicedGracken.ui.present_message(message)
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
