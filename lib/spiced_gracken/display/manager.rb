require 'spiced_gracken/display/help'
require 'spiced_gracken/display/base'
require 'spiced_gracken/display/terminal_curses/ui'
require 'spiced_gracken/display/bash/ui'

module SpicedGracken
  module Display
    class Manager
      attr_accessor :_ui

      delegate :start, to: :_ui
      delegate :add_line, to: :_ui
      delegate :message_from_gracken, to: :_ui

      def initialize(ui_klass)
        self._ui = ui_klass.new
      end
    end
  end
end
