module SpicedGracken
  module Http
    class Server
      attr_accessor :server

      # instantiate!
      def initialize(port: '')
        Display.success "listening on #{port}..."
        @server = TCPServer.new(port)
        listen
      rescue => e
        Display.alert e.message
        Display.fatal e.message
        Display.fatal e.backtrace.join("\n")
      end

      def listen
        loop do
          # use a seprate thread, acception multiple incoming connections
          Thread.start(@server.accept) do |connection|
            begin
              while (input = connection.gets)
                Display.debug 'server received message:'
                Display.debug input

                data = JSON.parse(input)
                update_sender_info(data)
                message = processes_message(data)
                Display.present_message message
              end
            rescue => e
              # rescue here so that the server doesn't stop listening
              Display.alert e.message
              Display.fatal e.message
              Display.fatal e.backtrace.join("\n")
            end
          end
        end
      end

      def processes_message(data)
        type = data['type']
        klass = Message::TYPES[type]

        unless klass
          Display.alert 'message recieved and not recognized...'
          return
        end

        klass.new(payload: data)
      end

      def update_sender_info(data)
        sender = data['sender']

        # if the sender isn't currently marked as active,
        # perform the server list exchange
        unless ActiveServers.exists?(sender['uid'])
          payload = Message::NodeListHash.new.render
          Client.send_to_and_close(
            address: sender['location'],
            payload: payload)
        end

        ActiveServers.update(
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
