module SpicedGracken
  module Message
    class PingReply < Base
      def initialize(
        message: '',
        name_of_sender: '',
        location: 'localhost',
        payload: nil)

        self.payload = payload || {
          'type' => PING_REPLY,
          'message' => '',
          'client' => SpicedGracken::NAME,
          'client_version' => SpicedGracken::VERSION,
          'time_sent' => Time.now.to_s, # not yet sent
          'sender' => {
            'name' => Settings['alias'],
            'location' => Settings['ip'] + ':' + Settings['port'],
            'uid' => Settings['uid']
          }
        }
      end

      def display
        'ping successful'.colorize(:light_black)
      end
    end
  end
end
