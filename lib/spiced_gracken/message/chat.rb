module SpicedGracken
  module Message
    class Chat < Base
      include Encryptor

      def initialize(
        message: '',
        name_of_sender: '',
        location: 'localhost',
        uid: '')

        @payload = {
          'type' => CHAT,
          'message' => message,
          'client' => SpicedGracken::NAME,
          'client_version' => SpicedGracken::VERSION,
          'time_sent' => nil, # not yet sent
          'sender' => {
            'name' => name_of_sender,
            'location' => location,
            'uid' => uid
          }
        }
        @time_recieved = Time.now
      end

      def display
        time_recieved = @time_recieved.strftime('%e/%m/%y %H:%I:%M').colorize(:light_magenta)
        s = "#{time_recieved} "
        s << "#{payload['sender']['name'].colorize(:cyan)} > "
        s << "#{payload['message']}"
        puts s
      end
    end
  end
end
