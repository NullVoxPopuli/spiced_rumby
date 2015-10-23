module SpicedRumby
  module GUI
    module Views
      class Input < Vedeu::ApplicationView

        def render
          Vedeu.render do
            view :input do

            end
          end
        end


        def clear
          Vedeu.trigger(:_clear_view_content, :input)
        end

      end
    end
  end
end
