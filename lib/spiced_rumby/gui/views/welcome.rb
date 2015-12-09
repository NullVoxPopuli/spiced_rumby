module SpicedRumby
  module GUI
    module Views
      class Welcome < Vedeu::ApplicationView
        def render
          width = Vedeu.width

          Vedeu.render do
            view :welcome do
              lines do
                line
                line
                line do
                  foreground '#ff0000'
                  centre 'Welcome to ' + SpicedRumby::NAME, width: width
                end
                line
                line
                line do
                  foreground '#ffffff'
                  centre SpicedRumby::NAME + ' is a simple chat client that implements mesh-chat.', width: width
                end
                line { centre " \tA decentralized chat system utilizing mesh networking.", width: width }
                line
                line
                line do
                  foreground '#555555'
                  centre "Press 'ctrl + c' to exit", width: width
                end
                line
                line do
                  foreground '#555555'
                  centre "'enter' to begin.", width: width
                end
              end
            end
          end
        end
      end
    end
  end
end
