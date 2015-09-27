module SpicedGracken
  module Message
    class Whisper < Base
      attr_accessor :_to

      def initialize(
        message: '',
        name_of_sender: '',
        location: 'localhost',
        to: '',
        payload: nil)
        super(message: message, name_of_sender: name_of_sender, location: location)

        self._to = to
        self.payload = payload if payload
      end

      def display
        time_sent = payload['time_sent']
        time = Date.parse(time_sent)
        time_recieved = time.strftime('%e/%m/%y %H:%I:%M')
        sender = payload['sender']['name']
        message = payload['message']

        to = _to.present? ? "->#{_to}" : ''
        "#{time_recieved} #{sender}#{to} > #{message}"
      end
    end
  end
end
