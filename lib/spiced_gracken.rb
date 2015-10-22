# require the core functionality
require 'meshchat'

# additional functionality
require 'spiced_gracken/version'
require 'spiced_gracken/cli_input'
require 'spiced_gracken/cli_output'

module SpicedGracken
  NAME = 'Spiced Gracken'

  module_function

  def start
    MeshChat.start(
      client_name: NAME,
      client_version: VERSION,
      display: CLIOutput,
      input: CLIInput,
      on_display_start: ->{ MeshChat::CLI.check_startup_settings }
    )
  end
end
