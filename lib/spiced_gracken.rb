require 'openssl'
require 'socket'
require 'json'
require 'colorize'

require 'spiced_gracken/version'
require 'spiced_gracken/help'
require 'spiced_gracken/settings'
require 'spiced_gracken/room'
require 'spiced_gracken/command_line_interface'
require 'spiced_gracken/encryptor'
require 'spiced_gracken/message/text'

module SpicedGracken
  NAME = "Spiced Gracken"

  module_function

  def start
    settings = Settings.new

    # start the user interface
    # interfaces are responsible for creating the client and server
    CommandLineInterface.new(settings: settings)
  end
end
