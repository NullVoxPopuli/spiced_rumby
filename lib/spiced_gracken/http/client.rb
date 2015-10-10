module SpicedGracken
  module Http
    class Client
      attr_accessor :_socket

      # if two people change 'localhost' to be eachother's machine,
      # they should be able to talk to eachother, assuming the do the
      # proper port  forwarding so that data on this port goes to that computer
      def initialize(location: '', port: '', silent: false)
        if location.blank? || port.blank?
          Display.alert "location and port must be specified"
          return
        end
        Display.info "connecting to #{location} on #{port}..." unless silent
        create_socket(location, port)
        Display.success 'connected!' unless silent
      end

      def create_socket(location, port)
        self._socket = TCPSocket.new(location, port)
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
      def self.send_to_and_close(location: '', payload: nil, encrypt_with: nil)
        ip, port = location.split(':')

        if encrypt_with
          payload = SpicedGracken::Encryptor.encrypt(payload, encrypt_with)
        end

        begin
          client = new(location: ip, port: port, silent: true)
          client.send(message: payload)
          client.close
        rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT
          Display.info "#{location} is not available"
          ActiveServers.remove(
            location: location
          )
        end
      end

    end
  end
end
