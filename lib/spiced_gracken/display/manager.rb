require 'spiced_gracken/display/help'
require 'spiced_gracken/display/base'
# TODO: optionally require these
require 'spiced_gracken/display/terminal_curses/ui'
require 'spiced_gracken/display/null/ui'
require 'spiced_gracken/display/bash/ui'

module SpicedGracken
  module Display

    class Manager
      attr_accessor :_ui

      delegate :start, to: :_ui
      delegate :add_line, to: :_ui
      delegate :info, to: :_ui
      delegate :warning, to: :_ui
      delegate :alert, to: :_ui
      delegate :success, to: :_ui
      delegate :chat, to: :_ui
      delegate :whisper, to: :_ui

      attr_accessor :_logger
      delegate :fatal, to: :_logger
      delegate :debug, to: :_logger
      delegate :error, to: :_logger

      def initialize(ui_klass)
        self._logger = Logger.new('debug.log')
        self._ui = ui_klass.new
      end

      def present_message(message)
        case message.class.name
        when Message::Chat.name
          chat message.display
        when Message::Whisper.name
          whisper message.display
        when Message::PingReply.name
          info message.display
        else
          add_line message.display
        end
      end
    end
  end
end
