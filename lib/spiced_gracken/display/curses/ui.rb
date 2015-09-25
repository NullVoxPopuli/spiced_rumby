require 'spiced_gracken/display/curses/chat_input'
require 'spiced_gracken/display/curses/output'

module SpicedGracken
  module Display
    module Curses
      class UI < Display::Base
        # gives us the following methods:
        # - init_screen
        # - lines
        # - cols
        # - refresh - draw the new screen
        # - crmode ?
        # - getch (get character)
        # - addstr (at position)
        # - setpos (put the cursor at x,y)
        # - close_screen
        #
        # For a full list:
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
          init_screen
          begin
            crmode
            noecho

            #  show_message("Hit any key")
            display_greeting
            display_ui

            # process_input
            refresh
          ensure
            close_screen
          end
        end

        def display_greeting
          welcome = Help.welcome
          hit = Help.hit_key
          setpos((lines - 5) / 2, (cols - welcome.length) / 2)
          addstr(welcome)
          setpos(lines / 2, (cols - hit.length) / 2)
          addstr(hit)
          refresh
          # wait for user input
          getch
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

      end
    end
  end
end
