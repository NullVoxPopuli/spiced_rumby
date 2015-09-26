module SpicedGracken
  module Display
    module TerminalCurses
      class ChatInput
        attr_accessor :_window
        attr_accessor :_current_input
        attr_accessor :_screen

        def initialize(screen)
          self._screen = screen
          self._window = Curses::Window.new(
            Curses.lines,
            Curses.cols,
            Curses.lines - 3,
            0)

          self._current_input = ''
        end

        def refresh
          _window.clrtoeol
          _window.clear
          # _window.deleteln
          _window.box('|', '-')
          _window.setpos(1, 2)
          _window.refresh
        end

        # require 'pry-byebug'
        def process_input
          loop do
            input = _window.getch
            # binding.pry
            # TODO: maybe change the text color based on if command or not
            if input == 10 # Curses::Key::ENTER
              refresh
              SpicedGracken.cli.create_input(_current_input)
              self._current_input = ''
            elsif input == 8 # Curses::Key::BACKSPACE
              curx = _window.curx
              cury = _window.cury
              _window.setpos(cury, curx - 1)
              _window.delch
              self._current_input = _current_input.chop
            elsif input.to_s == input
              _window.addch(input)
              self._current_input += input
              # do we ever want to break?
              # break
            end
          end
        end
      end
    end
  end
end
