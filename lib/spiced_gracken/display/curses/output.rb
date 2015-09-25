module SpicedGracken
  module Display
    module Curses
      class Output
        attr_accessor :_window
        attr_accessor :_chat
        attr_accessor :_screen

        def initialize(screen)
          self._screen = screen
          # window params:
          # heigh, width, top, left
          self._window = Curses::Window.new(
            Curses.lines - 4,
            Curses.cols,
            0,
            0)
          self._chat = []
          refresh
        end

        def refresh
          _window.clear
          _window.addstr(_chat.join("\n"))
          _window.refresh
        end

        def add_line(line)
          self._chat << line
          refresh
        end
      end
    end
  end
end
