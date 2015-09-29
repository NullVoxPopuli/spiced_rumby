module SpicedGracken
  module Message
    class Ping < Base
      def initialize(
        message: '',
        name_of_sender: '',
        location: 'localhost',
        payload: nil)

        self.payload = payload || {
          'type' => PING,
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
        name = payload['sender']['name']
        location = payload['sender']['location']

        "#{name}@#{location} pinged you.".colorize(:light_black)
      end

      def respond
        location = payload['sender']['location']

        SpicedGracken::Http::Client.send_to_and_close(
          address: location,
          payload: PingReply.new.render
        )
      end
    end
  end
end
