module SpicedRumby
  module GUI
    class Application

      # Bindings!!!!
      Vedeu.bind(:_initialize_) do
        Vedeu.trigger(:_goto_, :welcome, :show)
      end

      Vedeu.bind(:_command_) do |data|
        Vedeu.log(type: :info, message: data.inspect.to_s)
        Vedeu.log(type: :info, message: data.class.name)
        MeshChat::CLI.create_input(data)
      end

      Vedeu.bind :redraw_contacts do
        SpicedRumby::GUI::Controllers::Chat.contacts_list.render
      end

      Vedeu.configure do
        debug!
        root :welcome, :show
        log './gui.log'
        colour_mode 16_777_216
        terminal_mode :fake
        background '#ff0000' #Colorer::BACKGROUND
      end

      def self.start(argv = ARGV)
        Vedeu::Launcher.execute!(argv)
      end
    end
  end
end
