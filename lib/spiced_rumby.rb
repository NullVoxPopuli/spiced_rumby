# require the core functionality
require 'meshchat'

# additional functionality
require 'spiced_rumby/version'
require 'spiced_rumby/cli_input'
require 'spiced_rumby/cli_output'

module SpicedRumby
  NAME = 'Spiced Rumby'

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
