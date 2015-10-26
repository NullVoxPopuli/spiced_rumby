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
                line {
                  foreground '#ff0000'
                  centre 'Welcome to ' + SpicedRumby::NAME, width: width
                }
                line
                line
                line {
                  foreground '#ffffff'
                  centre SpicedRumby::NAME + " is a simple chat client that implements mesh-chat.", width: width
                }
                line { centre " \tA decentralized chat system utilizing mesh networking.", width: width }
                line
                line
                line {
                  foreground '#555555'
                  centre "Press 'ctrl + c' to exit",     width: width
                }
                line
                line {
                  foreground '#555555'
                  centre "'enter' to begin.", width: width
                }
              end
            end
          end
        end
      end
    end
  end
end
