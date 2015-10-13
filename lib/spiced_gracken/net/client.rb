module SpicedGracken
  module Net
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
          _socket.flush
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
          payload = Cipher.encrypt(payload, encrypt_with)
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

      # wrapper for adding encryption to a message
      def self.dispatch(node: nil, payload: '')
        if !(node && node.location)
          Display.alert "Node not found, or does not have a location"
          return
        end

        Display.debug "encrypting with #{node.alias_name}'s public key"

        send_to_and_close(
          location: node.location,
          payload: payload,
          encrypt_with: node.public_key
        )
      end

      def self.send_to(location: nil, payload: '')
        node = Models::Entry.find_by_location(location)

        dispatch(node: node, payload: payload)
      end

    end
  end
end
