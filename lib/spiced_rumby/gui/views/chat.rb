module SpicedRumby
  module GUI
    module Views
      class Chat < Vedeu::ApplicationView
        cattr_accessor :messages

        def initialize(*)
          super
          self.messages = []
        end

        def self.add_message(kind, text)
          messages << {
            kind: kind,
            message: text
          }

          Vedeu.log(type: :info, message: kind.to_s + ': ' + text.to_s)
          Vedeu.log(type: :info, message: 'num: ' + messages.count.to_s)

          # update the current chat
          SpicedRumby::GUI::Controllers::Chat.chats[:all].render(messages)
          # update the contacts list (incase of disconnections / reconnections)
          SpicedRumby::GUI::Controllers::Chat.contacts_list.render
          # scroll to the bottom of the chat
          Vedeu.trigger(:_cursor_bottom_, :chat)
        end

        def render(messages = nil)
          Vedeu.render do
            view :chat do
              messages ||= SpicedRumby::GUI::Views::Chat.messages
              messages.each do |message|
                SpicedRumby::GUI::Colorer.send(message[:kind], self, message[:message])
              end
            end
          end
        end
      end
    end
  end
end
