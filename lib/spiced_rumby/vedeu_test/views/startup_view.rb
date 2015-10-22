module SpicedRumby
  module VedeuTest
    class StartupView
      include Vedeu

      def show
        trigger(:_clear_)

        render do
          view 'title' do
          
          end
        end
      end

    end
  end
end
