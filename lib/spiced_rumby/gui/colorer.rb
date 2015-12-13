module SpicedRumby
  module GUI
    module Colorer
      TIME = '#CC66FF'
      WHISPER_TIME = '#662299'
      NAME = '#007777'
      WHISPER_NAME = '#004444'
      CHAT = '#DDDDDD'
      WHISPER_CHAT = '#777777'
      BACKGROUND = '#222222'
      FOREGROUND = '#ffffff'
      WARNING = '#ffff00'
      ALERT = '#ff0000'
      INFO = '#999999'
      SUCCESS = '#00ff00'
      ONLINE_CONTACT = FOREGROUND
      OFFLINE_CONTACT = '#444444'
      SELECTED_CONTACT_BACKGROUND = '#333333'

      module_function

      def add_line(renderer, msg)
        renderer.line do
          stream do
            foreground CHAT
            text msg, mode: :wrap
          end
        end
      end

      def alert(renderer, msg)
        renderer.line do
          stream do
            foreground ALERT
            text msg#, mode: :wrap
          end
        end
      end

      def info(renderer, msg)
        renderer.line do
          stream do
            foreground INFO
            text msg, mode: :wrap
          end
        end
      end

      def warning(renderer, msg)
        renderer.line do
          stream do
            foreground WARNING
            text msg, mode: :wrap
          end
        end
      end

      def success(renderer, msg)
        renderer.line do
          stream do
            foreground SUCCESS
            text msg, mode: :wrap
          end
        end
      end

      def chat(renderer, msg)
        time, name, message = split_chat(msg)
        Vedeu.log(type: :info, message: 'coloring message pieces:')
        Vedeu.log(type: :info, message: time.to_s)
        Vedeu.log(type: :info, message: name.to_s)
        Vedeu.log(type: :info, message: message.to_s)

        renderer.line do
          stream do
            foreground TIME
            text time
          end
          stream do
            foreground NAME
            text name
          end
          stream do
            foreground CHAT
            text message
          end
        end
      end

      def whisper(renderer, msg)
        time, name, message = split_chat(msg)
        renderer.line do
          stream do
            foreground WHISPER_TIME
            text time
          end
          stream do
            foreground WHISPER_NAME
            text name
          end
          stream do
            foreground WHISPER_CHAT
            text message, mode: :wrap
          end
        end
      end

      def split_chat(msg)
        words = msg.split(' ')
        time = words[0..1].join(' ') + ' '
        name = words[2] + ' '
        message = words[3..words.length].join(' ')

        [time, name, message]
      end
    end
  end
end
