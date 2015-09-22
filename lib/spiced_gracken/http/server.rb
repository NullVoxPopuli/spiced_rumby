module SpicedGracken
  module Http
    class Server
      attr_accessor :server

      # instantiate!
      def initialize(port: '')
        puts "listening on #{port}...".colorize(:green)
        @server = TCPServer.new(port)

        loop do
          Thread.start(@server.accept) do |connection|
            while (input = connection.gets)
              data = JSON.parse(input)

              type = data["type"]
              message = nil
              # figure out what to do
              case type
              when "text"
                message = Message::Text.new
                message.payload = data
              else
                puts "message recieved and not recognized...".colorize(:red)
                puts input
              end

              message.display
            end
          end
        end


      end
    end
  end
end
