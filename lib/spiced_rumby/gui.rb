require 'spiced_rumby/gui/colorer'
require 'spiced_rumby/gui/models/keymaps/_global_'
require 'spiced_rumby/gui/models/keymaps/welcome'
require 'spiced_rumby/gui/models/keymaps/input'
require 'spiced_rumby/gui/models/keymaps/contacts'
require 'spiced_rumby/gui/views/interfaces/chat'
require 'spiced_rumby/gui/views/interfaces/contacts'
require 'spiced_rumby/gui/views/interfaces/input'
require 'spiced_rumby/gui/views/interfaces/welcome'
require 'spiced_rumby/gui/views/chat'
require 'spiced_rumby/gui/views/input'
require 'spiced_rumby/gui/views/contacts'
require 'spiced_rumby/gui/views/welcome'
require 'spiced_rumby/gui/controllers/welcome_controller'
require 'spiced_rumby/gui/controllers/chat_controller'
require 'spiced_rumby/gui/application'

module SpicedRumby
  module GUI
    class MeshChatHook
      def start
        SpicedRumby::GUI::Application.start(ARGV)
      end

      def add_line(line)
        Views::Chat.add_message(:line, line)
      end

      def info(msg)
        Views::Chat.add_message(:info, msg)
      end

      def warning(msg)
        Views::Chat.add_message(:warning, msg)
      end

      def alert(msg)
        Views::Chat.add_message(:alert, msg)
      end

      def success(msg)
        Views::Chat.add_message(:success, msg)
      end

      def chat(msg)
        Views::Chat.add_message(:chat, msg)
      end

      def whisper(msg)
        Views::Chat.add_message(:whisper, msg)
      end
    end
  end
end
