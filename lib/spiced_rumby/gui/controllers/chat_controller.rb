module SpicedRumby
  module GUI
    module Controllers
      class Chat < Vedeu::ApplicationController
        controller_name :chat

        action :show

        def show
          Vedeu.trigger(:_show_group_, :main)

          Views::Chat.new.render
          Views::Contacts.new.render
          Views::Input.new.render

          Vedeu.trigger(:_focus_by_name_, :input)
        end
      end
    end
  end
end
