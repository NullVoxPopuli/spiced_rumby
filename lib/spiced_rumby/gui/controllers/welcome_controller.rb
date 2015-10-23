module SpicedRumby
  module GUI
    module Controllers
      class Welcome < Vedeu::ApplicationController
        controller_name :welcome

        action :show
        def show
          SpicedRumby::GUI::Views::Welcome.new.render
          Vedeu.trigger(:_focus_by_name_, :welcome)
        end
      end
    end
  end
end
