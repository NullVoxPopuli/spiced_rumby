module SpicedRumby
  module VedeuTest

    class Application
      Vedeu.bind(:_initialize_) {
        Vedeu.trigger(:_show_view_, :startup)
        Vedeu.trigger(:_refresh_)
      }

      Vedeu.configure do
        # Empty configure block is needed.
      end

      Vedeu.interface :startup do
        # Define all of the interface in one place.
        background '#000000'
        foreground '#00ff00'
        geometry do
          height   20
          width    100
          centred!
        end


        # (You usually specify the views outside the interface block).
        Vedeu.views do
          view :startup do
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
                foreground '#333333'
                centre "Press 'q' to exit,",     width: 24
              }
              line {
                foreground '#333333'
                centre " 's' to begin.", width: 24
              }
            end
          end
        end
        keymap do
          key('q') { Vedeu.exit }
          key('s') { Application.render_views }
        end
      end

      def self.start(argv = ARGV)
        Vedeu::Launcher.execute!(argv)
        MeshChat.start(
          # client_name: NAME,
          # client_version: VERSION,
          display: CLIOutput,
          # input: CLIInput,
          notifier: Notifier
          # on_display_start: ->{ MeshChat::CLI.check_startup_settings }
        )

      end

      private

      def self.render_views
        SpicedRumby::VedeuTest::Views.Contacts.render
      end
    end
  end
end
