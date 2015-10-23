module SpicedRumby
  module GUI
    module Views
      class Chat < Vedeu::ApplicationView

        cattr_accessor :messages

        def initialize(*)
          super
          self.messages = []
          # self.class.add_message(:warning, "warning")
          # self.class.add_message(:alert, "alert")
          self.class.add_message(:whisper, "23/10/15 13:01:36 nvp->etk > hi, this is a whisper")
          self.class.add_message(:chat, "23/10/15 13:01:36 nvp > hi, how are ya?")
        end

        def self.add_message(kind, text)
          messages << {
            kind: kind,
            message: text
          }
        end

        def render
          Vedeu.render do
            view :chat do
              background SpicedRumby::GUI::Colorer::BACKGROUND
              geometry do
                input = use(:input)
                align :top, :left, input.width, input.north
              end

              # lines do
                SpicedRumby::GUI::Views::Chat.messages.each do |message|
                  SpicedRumby::GUI::Colorer.send(message[:kind], self, message[:message])
                end
              # end
            end
          end
        end

      end
    end
  end
end
