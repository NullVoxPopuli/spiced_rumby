module SpicedRumby
  module GUI

    class Application
      Vedeu.bind(:_initialize_){
          Vedeu.trigger(:_goto_, :welcome, :show)
      }

      Vedeu.bind(:_command_) do |data|
        Vedeu.log(type: :info, message: data.inspect.to_s)
        Vedeu.log(type: :info, message: data.class.name)
        MeshChat::CLI.create_input(data)
      end

      Vedeu.configure do
        debug!
        root :welcome, :show
        log './gui.log'
        colour_mode 16777216
        terminal_mode :fake
        # interactive!
      end


      def self.start(argv = ARGV)
        Vedeu::Launcher.execute!(argv)
      end
    end
  end
end
