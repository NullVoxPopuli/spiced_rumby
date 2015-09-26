require 'spiced_gracken/display/terminal_curses/chat_input'
require 'spiced_gracken/display/terminal_curses/output'

module SpicedGracken
  module Display
    module TerminalCurses
      class UI < Display::Base
        # http://ruby-doc.org/stdlib-2.0.0/libdoc/curses/rdoc/Curses.html
        include Curses

        attr_accessor :_current_input
        attr_accessor :_chat_input
        attr_accessor :_chat_output
        attr_accessor :_chat
        attr_accessor :_sidebar

        def initialize
          self._chat = []
          self._current_input = ''
        end

        def start
          Curses.init_screen
          begin
            Curses.crmode
            Curses.noecho

            #  show_message("Hit any key")
            display_greeting
            display_ui

            # process_input
            Curses.refresh
          ensure
            Curses.close_screen
          end
        end

        def display_greeting
          welcome = Help.welcome
          hit = Help.hit_key
          Curses.setpos((lines - 5) / 2, (cols - welcome.length) / 2)
          Curses.addstr(welcome)
          Curses.setpos(lines / 2, (cols - hit.length) / 2)
          Curses.addstr(hit)
          Curses.refresh
          # wait for user input
          Curses.getch
        end

        def display_ui
          self._chat_output = Output.new(self)
          self._chat_input = ChatInput.new(self)
          update
        end

        def update
          _chat_input.refresh
          _chat_output.refresh
          refresh
        end

        def add_line(line)
          _chat_output.add_line(line)
        end

        def info(msg)
          add_line(msg)
        end

        def warning(msg)
          add_line(msg)
        end

      end
    end
  end
end
