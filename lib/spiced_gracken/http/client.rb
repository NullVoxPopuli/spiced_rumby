module SpicedGracken
  module Http
    class Client
      attr_accessor :socket

      # if two people change 'localhost' to be eachother's machine,
      # they should be able to talk to eachother, assuming the do the
      # proper port  forwarding so that data on this port goes to that computer
      def initialize(address: '', port: '')
        puts "connecting to #{address} on #{port}...".colorize(:yellow)
        @socket = TCPSocket.new(address, port)
				puts "connected!".colorize(:green)
      end

      def send(message: '' )
        @socket.puts message
      end

    end
  end
end
