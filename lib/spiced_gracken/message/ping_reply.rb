module SpicedGracken
  module Message
    class PingReply < Base

      def initialize(*args)
        self.payload = {
          'type' => PING_REPLY,
          'message' => '',
          'client' => SpicedGracken::NAME,
          'client_version' => SpicedGracken::VERSION,
          'time_sent' => Time.now.to_s, # not yet sent
          'sender' => {
            'name' => SpicedGracken.settings['alias'],
            'location' => SpicedGracken.settings['ip'] + ':' + SpicedGracken.settings['port'],
            'uid' => SpicedGracken.settings['uid']
          }
        }
      end

      def display
        puts 'ping successful'.colorize(:light_black)
      end

    end
  end
end
