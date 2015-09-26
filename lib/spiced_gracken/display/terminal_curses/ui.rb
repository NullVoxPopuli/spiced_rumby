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

        Curses.init_pair(COLOR_YELLOW, COLOR_YELLOW, COLOR_BLACK)
        Curses.init_pair(COLOR_RED, COLOR_RED, COLOR_BLACK)
        Curses.init_pair(COLOR_MAGENTA, COLOR_MAGENTA, COLOR_BLACK)
        Curses.init_pair(COLOR_CYAN, COLOR_CYAN, COLOR_BLACK)
        Curses.init_pair(COLOR_WHITE, COLOR_WHITE, COLOR_BLACK)
        Curses.init_pair(COLOR_GREEN, COLOR_GREEN, COLOR_BLACK)
        Curses.init_pair(COLOR_BLUE, COLOR_BLUE, COLOR_BLACK)

        WARNING = Curses.color_pair(COLOR_YELLOW)
        ALERT = Curses.color_pair(COLOR_RED)
        TIME = Curses.color_pair(COLOR_MAGENTA)
        SENDER = Curses.color_pair(COLOR_CYAN)
        TEXT = Curses.color_pair(COLOR_WHITE)
        WHISPER_SENDER = Curses.color_pair(COLOR_GREEN)
        WHISPER_TIME = Curses.color_pair(COLOR_BLUE)

        # init_pair(id, foreground, background)
        def initialize
          self._chat = []
          self._current_input = ''
        end

        def start
          Curses.init_screen
          Curses.start_color

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
          _chat_input.process_input
        end

        def update
          _chat_input.refresh
          _chat_output.refresh
          refresh
        end

        delegate :add_line, to: :_chat_output
        delegate :info, to: :_chat_output
        delegate :warning, to: :_chat_output
        delegate :alert, to: :_chat_output
      end
    end
  end
end
