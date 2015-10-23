module SpicedRumby
  module GUI
    module Controllers
      class Chat < Vedeu::ApplicationController
        controller_name :chat

        action :show

        def show
          Vedeu.trigger(:_hide_interface_, :welcome)

          Vedeu.trigger(:_show_group_, :main)

          Views::Contacts.new.render
          Views::Input.new.render
          Views::Chat.new.render

          Vedeu.trigger(:_focus_by_name_, :input)
        end
      end
    end
  end
end
