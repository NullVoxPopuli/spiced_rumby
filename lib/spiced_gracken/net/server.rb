module SpicedGracken
  module Net
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
        # TODO: extract the body of the loop to a method
        # TODO: extract the body of the Thread to a method
        # TODO: why do I have a thread here?
        #process_responses while true
        loop do
          # use a seprate thread, acception multiple incoming connections
          Thread.start(@server.accept) do |request|
            begin
              chunks = []
              while (chunk = request.gets)
                chunks << chunk
              end

              input = chunks.join
              response = Response.new(input)
              message = response.message
              next unless message

              update_sender_info(response.json)

              Display.present_message message
              request.close
            rescue => e
              # rescue here so that the server doesn't stop listening
              Display.alert e.message
              Display.fatal e.message
              Display.fatal e.backtrace.join("\n")
            end
          end
        end
      end

      def update_sender_info(json)
        sender = json['sender']

        # if the sender isn't currently marked as active,
        # perform the server list exchange
        unless ActiveServers.exists?(sender['uid'])
          payload = Message::NodeListHash.new.render
          Client.send_to(
            location: sender['location'],
            payload: payload)
        end

        ActiveServers.update(
          sender['uid'],
          location: sender['location'],
          alias_name: sender['alias']
        )
      end

      def location
        "#{server.location}:#{server.port}"
      end
    end
  end
end
