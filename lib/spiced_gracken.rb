require 'openssl'
require 'socket'
require 'json'
require 'date'
require 'colorize'
require 'curses'
require 'io/console'
require 'logger'

require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/object/try'

require 'spiced_gracken/version'
require 'spiced_gracken/display'
require 'spiced_gracken/display/manager'
require 'spiced_gracken/config/entry'
require 'spiced_gracken/config/hash_file'
require 'spiced_gracken/config/settings'
require 'spiced_gracken/config/server_list'
require 'spiced_gracken/config/active_server_list'
require 'spiced_gracken/cli'
require 'spiced_gracken/encryptor'
require 'spiced_gracken/message'

module SpicedGracken
  NAME = 'Spiced Gracken'

  Settings = Config::Settings
  ServerList = Config::ServerList
  ActiveServers = Config::ActiveServerList

  module_function

  def start(selected_ui)
    # start the user interface
    # interfaces are responsible for creating the client and server
    @@cli = CLI.new

    ui = Display::Bash::UI
    if !selected_ui.blank?
      if selected_ui != 'bash'
        ui = Display::TerminalCurses::UI
      elsif selected_ui == 'null'
        ui = Display::Null::UI
      end

    end

    @@display = Display::Manager.new(ui)
    @@display.start do
      @@cli.check_startup_settings
    end
  end

  def ui
    @@display
  end

  def cli
    @@cli
  end
end
