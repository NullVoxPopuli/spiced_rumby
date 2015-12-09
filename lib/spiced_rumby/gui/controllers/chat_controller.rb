module SpicedRumby
  module GUI
    module Controllers
      class Chat < Vedeu::ApplicationController
        controller_name :chat
        action :show

        cattr_accessor :chats
        cattr_accessor :contacts_list

        def show
          self.class.chats ||= {}
          Vedeu.trigger(:_hide_interface_, :welcome)

          Vedeu.trigger(:_show_group_, :main)

          Vedeu.menu(:contacts) do
            items(SpicedRumby::GUI::Views::Contacts.contacts)
            # Vedeu.bind(:_menu_next_, :contacts)
            # Vedeu.bind(:_menu_select_, :contacts)
            # Vedeu.bind(:_menu_prev_, :contacts)
          end

          self.class.contacts_list = Views::Contacts.new
          contacts_list.render
          Views::Input.new.render

          all = Views::Chat.new
          all.render
          self.class.chats[:all] = all

          Vedeu.trigger(:_focus_by_name_, :input)
        end
      end
    end
  end
end
