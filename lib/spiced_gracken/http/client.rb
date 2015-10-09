module SpicedGracken
  module Http
    class Client
      attr_accessor :_socket

      # if two people change 'localhost' to be eachother's machine,
      # they should be able to talk to eachother, assuming the do the
      # proper port  forwarding so that data on this port goes to that computer
      def initialize(address: '', port: '', silent: false)
        if address.blank? || port.blank?
          Display.alert "address and port must be specified"
          return
        end
        Display.info "connecting to #{address} on #{port}..." unless silent
        create_socket(address, port)
        Display.success 'connected!' unless silent
      end

      def create_socket(address, port)
        self._socket = TCPSocket.new(address, port)
      end

      def send(message: '')
        Display.debug 'client sent message:'
        Display.debug message
        if _socket
          _socket.puts message
        else
          Display.alert 'transmitter not running'
        end
      end

      def close
        _socket.try(:close)
      end

      # @param [String] encrypt_with the uid of who to use for encryption
      def self.send_to_and_close(address: '', payload: nil, encrypt_with: nil)
        ip, port = address.split(':')

        if encrypt_with
          payload = Message::Encryptor.encrypt(payload, encrypt_with)
        end

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
