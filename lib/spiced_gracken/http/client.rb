module SpicedGracken
  module Http
    class Client
      attr_accessor :socket

      # if two people change 'localhost' to be eachother's machine,
      # they should be able to talk to eachother, assuming the do the
      # proper port  forwarding so that data on this port goes to that computer
      def initialize(address: '', port: '', silent: false)
        Display.info "connecting to #{address} on #{port}..." unless silent
        create_socket(address, port)
        Display.success 'connected!' unless silent
      end

      def create_socket(address, port)
        @socket = TCPSocket.new(address, port)
      end

      def send(message: '')
        Display.debug 'client sent message:'
        Display.debug message
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
          Display.info "#{address} is not available"
          ActiveServers.remove(
            address: address
          )
        end
      end
    end
  end
end
