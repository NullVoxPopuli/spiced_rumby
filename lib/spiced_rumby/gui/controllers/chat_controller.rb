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
          self.class.contacts_list = Views::Contacts.new

          Vedeu.trigger(:_hide_interface_, :welcome)
          Vedeu.trigger(:_show_group_, :main)

          Vedeu.menu(:contacts) do
            items(SpicedRumby::GUI::Views::Contacts.contacts)
          end

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
