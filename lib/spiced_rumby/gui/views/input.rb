module SpicedRumby
  module GUI
    module Views
      class Input < Vedeu::ApplicationView

        def render
          Vedeu.render do
            view :input do
              background SpicedRumby::GUI::Colorer::BACKGROUND

              current_chat = "All Chat"
              border do
                title  "#{SpicedRumby::NAME}: v#{SpicedRumby::VERSION} - #{current_chat}"
              end
            end
          end
        end


        def clear
          #Vedeu.trigger(:_clear_view_content, :input)
        end

      end
    end
  end
end
