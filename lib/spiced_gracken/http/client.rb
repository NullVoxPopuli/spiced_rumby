module SpicedGracken
  module Http
    class Client
      attr_accessor :socket

      # if two people change 'localhost' to be eachother's machine,
      # they should be able to talk to eachother, assuming the do the
      # proper port  forwarding so that data on this port goes to that computer
      def initialize(address: '', port: '', silent: false)
        puts "connecting to #{address} on #{port}...".colorize(:yellow) unless silent
        @socket = TCPSocket.new(address, port)
        puts 'connected!'.colorize(:green) unless silent
      end

      def send(message: '')
        @socket.puts message
      end

      def close
        @socket.close
      end

      def self.send_to_and_close(address: '', payload: nil)
        ip, port = address.split(':')

        begin
          client = new(address: ip, port: port, silent: true)
          client.send(message: payload)
          client.close
        rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
          puts "#{address} is not available"
          SpicedGracken.server_list.inactive!(address)
        end
      end
    end
  end
end
