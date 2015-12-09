module SpicedRumby
  module GUI
    module Views
      class Input < Vedeu::ApplicationView
        def render
          Vedeu.render do
            view :input do
              background SpicedRumby::GUI::Colorer::BACKGROUND

              current_chat = 'All'
              border do
                title "To: #{current_chat}"
                background SpicedRumby::GUI::Colorer::BACKGROUND
              end
            end
          end
        end

        def clear
          # Vedeu.trigger(:_clear_view_content, :input)
        end
      end
    end
  end
end
