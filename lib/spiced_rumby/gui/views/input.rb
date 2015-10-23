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

              geometry do
                y Vedeu.height - 5
                x 1
                xn use(:contacts).west
                yn Vedeu.height
                # align :bottom, :left, Vedeu.width - use(:contacts).width, 5
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
