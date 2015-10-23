module SpicedRumby
  module GUI
    module Views
      class Welcome < Vedeu::ApplicationView


        def render
          Vedeu.render do
            view :welcome do
              lines do
                line {
                  foreground '#ff0000'
                  centre 'Welcome to ' + SpicedRumby::NAME
                }
                line
                line
                line {
                  foreground '#ffffff'
                  centre SpicedRumby::NAME + " is a simple chat client that implements mesh-chat."}
                line { centre " \tA decentralized chat system utilizing mesh networking." }
                line
                line {
                  foreground '#555555'
                  centre "Press 'q' to exit,",     width: 24
                }
                line {
                  foreground '#555555'
                  centre " 's' to begin.", width: 24
                }
              end
            end
          end
        end
      end
    end
  end
end
