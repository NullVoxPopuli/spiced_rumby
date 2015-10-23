require 'spiced_rumby/gui/models/keymaps/_global_'
require 'spiced_rumby/gui/models/keymaps/welcome'
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
    end
  end
end
