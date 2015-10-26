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

      module_function

      def add_line(renderer, msg)
        renderer.line {
          stream{
            foreground CHAT
            left msg
          }
        }
      end

      def alert(renderer, msg)
        renderer.line {
          stream{
            foreground ALERT
            left msg
          }
        }
      end

      def info(renderer, msg)
        renderer.line {
          stream{
            foreground INFO
            left msg
          }
        }
      end

      def warning(renderer, msg)
        renderer.line {
          stream{
            foreground WARNING
            left msg
          }
        }
      end

      def success(renderer, msg)
        renderer.line {
          stream{
            foreground SUCCESS
            left msg
          }
        }
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
