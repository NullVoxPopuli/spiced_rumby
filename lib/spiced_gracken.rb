# require the core functionality
require 'meshchat'

# additional functionality
require 'spiced_gracken/version'
require 'spiced_gracken/display/help'
require 'spiced_gracken/display/bash/ui'
require 'spiced_gracken/display/terminal_curses/ui'



module SpicedGracken
  NAME = 'Spiced Gracken'

  module_function

  def start(selected_ui)
    ui = Display::Bash::UI
    if !selected_ui.blank?
      if selected_ui != 'bash'
        ui = Display::TerminalCurses::UI
      elsif selected_ui == 'null'
        ui = Display::Null::UI
      end
    end

    MeshChat.start(
      client_name: NAME,
      client_version: VERSION,
      display: ui,
      on_display_start: ->{ MeshChat::CLI.check_startup_settings }
    )
  end
end
