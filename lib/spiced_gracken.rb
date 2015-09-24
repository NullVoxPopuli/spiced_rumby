require 'openssl'
require 'socket'
require 'json'
require 'date'
require 'colorize'
require 'active_support/core_ext/module/delegation'

require 'spiced_gracken/version'
require 'spiced_gracken/help'
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

  def start
    @@settings = Config::Settings.new
    @@server_list = Config::ServerList.new

    # start the user interface
    # interfaces are responsible for creating the client and server
    cli = CLI.new(settings: settings)
    cli.listen_for_commands
  end

  def self.settings
    @@settings
  end

  def self.server_list
    @@server_list
  end
end
