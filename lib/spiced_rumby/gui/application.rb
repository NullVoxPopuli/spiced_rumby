module SpicedRumby
  module GUI

    class Application
      Vedeu.bind(:_initialize_){
          Vedeu.trigger(:_goto_, :welcome, :show)
      }
      #
      # Vedeu.bind(:_refresh_){
      #   Views::Contacts.new.render
      #   Views::Input.new.render
      #   Views::Chat.new.render
      # }


      Vedeu.bind(:_editor_execute_) do |data|
         log(type: :info, message: data)
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
