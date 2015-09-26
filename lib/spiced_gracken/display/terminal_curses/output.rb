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
          SpicedGracken.ui.debug("addline: #{line}")
          # _chat << line
          # _screen.update

          # format / colorize!
          _window.addstr(line + "\n")
          refresh
        end

        def chat(msg)
          SpicedGracken.ui.debug("chat: #{msg}")

          words = msg.split(' ')
          time = words[0..1]
          name = words[2]
          message = words[3..words.length]

          output_with_color(time.join(' ') + ' ', TerminalCurses::UI.time, intensity: Curses::A_BOLD)
          output_with_color(name + ' ', TerminalCurses::UI.sender, intensity: Curses::A_BOLD)
          output_with_color(message.join(' '), TerminalCurses::UI.text, intensity: Curses::A_BOLD)
          _window.addstr("\n")
          refresh
        end

        def whisper(msg)
          SpicedGracken.ui.debug("whisper: #{msg}")

          words = msg.split(' ')
          time = words[0..1]
          name = words[2]
          message = words[3..words.length]

          output_with_color(time.join(' ') + ' ', TerminalCurses::UI.time, intensity: Curses::A_DIM)
          output_with_color(name + ' ', TerminalCurses::UI.sender, intensity: Curses::A_DIM)
          output_with_color(message.join(' '), TerminalCurses::UI.text, intensity: Curses::A_DIM)
          _window.addstr("\n")
          refresh
        end

        # does not add a newline
        def output_with_color(text, color, intensity: Curses::A_NORMAL)
          _window.attron(color|intensity)  {
            _window.addstr(text)
          }
          refresh
        end

        def success(msg)
          SpicedGracken.ui.debug("success: #{msg}")
          _window.attron(TerminalCurses::UI.success|Curses::A_NORMAL)  {
            _window.addstr(msg + "\n")
          }
          refresh
        end

        def info(msg)
          SpicedGracken.ui.debug("info: #{msg}")
          output_with_color(msg + "\n", TerminalCurses::UI.sender)
          refresh
        end

        def warning(msg)
          SpicedGracken.ui.debug("warning: #{msg}")
          _window.attron(TerminalCurses::UI.warning|Curses::A_NORMAL) {
            _window.addstr(msg + "\n")
           }
           refresh
        end

        def alert(msg)
          SpicedGracken.ui.debug("alert: #{msg}")
          _window.attron(TerminalCurses::UI.alert|Curses::A_NORMAL) {
            _window.addstr(msg + "\n")
           }
          refresh
        end
      end
    end
  end
end
