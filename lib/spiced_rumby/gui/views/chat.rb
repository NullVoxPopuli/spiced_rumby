module SpicedRumby
  module GUI
    module Views
      class Chat < Vedeu::ApplicationView


        def render
          Vedeu.render do
            view :chat do

              lines do
                line{
                  foreground '#ff0000'
                  left "#{SpicedRumby::NAME}: v#{SpicedRumby::VERSION}"
                }
                line { 'something someone said' }
                line { 'something someone else said'}
              end
            end
          end
        end

      end
    end
  end
end
