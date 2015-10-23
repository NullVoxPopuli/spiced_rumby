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

      module_function

      def alert(p, msg)
        msg
      end

      def warning(p, msg)
        msg
      end

      def chat(renderer, msg)
        time, name, message = split_chat(msg)
        renderer.line{

          stream {
            foreground TIME
            left time
          }
          stream{
            foreground NAME
            left name
          }
          stream {
            foreground CHAT
            left message
          }
        }
      end

      def whisper(renderer, msg)
        time, name, message = split_chat(msg)
        renderer.line{

          stream {
            foreground WHISPER_TIME
            left time
          }
          stream{
            foreground WHISPER_NAME
            left name
          }
          stream {
            foreground WHISPER_CHAT
            left message
          }
        }
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
