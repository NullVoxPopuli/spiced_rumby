module SpicedRumby
  module GUI
    class InputHook < MeshChat::CLI::Base
      class << self
        def autocompletes
          commands = MeshChat::CLI::COMMAND_MAP.map { |k, _v| "/#{k}" }
          aliases = MeshChat::Node.all.map { |n| "#{n.alias_name}" }
          commands + aliases
        end
      end

      # called every time meshchat wants a line of text from the user
      def get_input
        Vedeu.read(nil, mode: :fake)
      end
    end
  end
end
