require 'openssl'
require 'socket'
require 'json'
require 'date'
require 'colorize'
require 'curses'

require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/object/try'

require 'spiced_gracken/version'
require 'spiced_gracken/display/manager'
require 'spiced_gracken/config/entry'
require 'spiced_gracken/config/hash_file'
require 'spiced_gracken/config/settings'
require 'spiced_gracken/config/server_list'
require 'spiced_gracken/config/active_server_list'
require 'spiced_gracken/room'
require 'spiced_gracken/cli'
require 'spiced_gracken/encryptor'
require 'spiced_gracken/message'

module SpicedGracken
  NAME = 'Spiced Gracken'

  module_function

  def start(selected_ui)
    @@settings = Config::Settings.new
    @@server_list = Config::ServerList.new
    @@active_servers = Config::ActiveServerList.new

    # start the user interface
    # interfaces are responsible for creating the client and server
    @@cli = CLI.new

    ui = Display::Bash::UI
    if !selected_ui.blank? && selected_ui != 'bash'
      ui = Display::TerminalCurses::UI
    end

    # reset the terminal's output
    system("stty raw opost -echo")

    @@display = Display::Manager.new(ui)
    @@display.start
  end

  def self.settings
    @@settings
  end

  def self.server_list
    @@server_list
  end

  def active_server_list
    @@active_servers
  end

  def display
    @@display
  end

  def ui
    @@display
  end

  def cli
    @@cli
  end
end
