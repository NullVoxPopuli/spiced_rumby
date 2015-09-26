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

        # init_pair(id, foreground, background)
        def initialize
          self._chat = []
          self._current_input = ''
        end

        def start
          Curses.init_screen
          Curses.start_color
          self.class.init_colors
          begin
            Curses.crmode
            Curses.noecho

            #  show_message("Hit any key")
            display_greeting
            display_ui
            yield if block_given?
            _chat_input.process_input

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

        delegate :add_line, to: :_chat_output
        delegate :info, to: :_chat_output
        delegate :warning, to: :_chat_output
        delegate :alert, to: :_chat_output
        delegate :success, to: :_chat_output
        delegate :chat, to: :_chat_output
        delegate :whisper, to: :_chat_output

        def self.init_colors
          Curses.init_pair(COLOR_YELLOW, COLOR_YELLOW, COLOR_BLACK)
          Curses.init_pair(COLOR_RED, COLOR_RED, COLOR_BLACK)
          Curses.init_pair(COLOR_MAGENTA, COLOR_MAGENTA, COLOR_BLACK)
          Curses.init_pair(COLOR_CYAN, COLOR_CYAN, COLOR_BLACK)
          Curses.init_pair(COLOR_WHITE, COLOR_WHITE, COLOR_BLACK)
          Curses.init_pair(COLOR_GREEN, COLOR_GREEN, COLOR_BLACK)
          Curses.init_pair(COLOR_BLUE, COLOR_BLUE, COLOR_BLACK)
        end

        def self.warning
          Curses.color_pair(COLOR_YELLOW)
        end

        def self.alert
          Curses.color_pair(COLOR_RED)
        end

        def self.time
          Curses.color_pair(COLOR_MAGENTA)
        end

        def self.sender
          Curses.color_pair(COLOR_CYAN)
        end

        def self.text
          Curses.color_pair(COLOR_WHITE)
        end

        def self.success
          Curses.color_pair(COLOR_GREEN)
        end

        def self.whisper_sender
          Curses.color_pair(COLOR_GREEN)
        end

        def self.whisper_time
          Curses.color_pair(COLOR_BLUE)
        end
      end
    end
  end
end
