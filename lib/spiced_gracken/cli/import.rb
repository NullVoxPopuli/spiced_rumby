module SpicedGracken
  class CLI
    class Import < CLI::Command
      def handle
        if command_valid?
          node = Models::Entry.import_from_file(filename)
          if node.valid? && node.persisted?
            Display.success "#{node.alias_name} successfully imported"
          else
            Display.alert "#{node.alias_name} is invalid"
            Display.alert node.errors.full_messages.join("\n")
          end
        else
          Display.alert usage
        end
      end

      def usage
        'Usage: /import {filename}'
      end

      def command_valid?
        filename.present?
      end

      def filename
        sub_command
      end
    end
  end
end
