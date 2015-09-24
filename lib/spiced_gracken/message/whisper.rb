module SpicedGracken
  module Message
    class Whisper < Base
      attr_accessor :_to

      def initialize(
        message: '',
        name_of_sender: '',
        location: 'localhost',
        to: '')
        super(message: message, name_of_sender: name_of_sender, location: location)

        self._to = to
      end

      def display
        time_sent = payload['time_sent']
        time = Date.parse(time_sent)
        time_recieved = time.strftime('%e/%m/%y %H:%I:%M').colorize(:magenta)

        s = "#{time_recieved} "
        s << "#{payload['sender']['name'].colorize(:light_black)}"

        if _to.present?
          s << "#{'->'.colorize(:light_black)}"
          s << "#{_to.colorize(:light_black)}"
        end

        s << ' > '
        s << "#{payload['message']}"
        puts s
      end
    end
  end
end
