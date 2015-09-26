module SpicedGracken
  module Display
    module TerminalCurses
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
        end

        def refresh
          # _window.clear
          # _window.addstr(_chat.join("\n"))
          _window.refresh
        end

        def add_line(line)
          # _chat << line
          # _screen.update
          _window.addstr(line)
          refresh
        end

        def info(msg)
          _window.attron(TerminalCurses::UI::SENDER|Curses::A_NORMAL)  {
            _window.addstr(msg)
           }
           refresh
        end

        def warning(msg)
          _window.attron(TerminalCurses::UI::WARNING|Curses::A_NORMAL) {
            _window.addstr(msg)
           }
           refresh
        end

        def alert(msg)
          _window.attron(TerminalCurses::UI::ALERT|Curses::A_NORMAL) {
            _window.addstr(msg)
           }
        end
      end
    end
  end
end
