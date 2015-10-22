# helper gems
require 'libnotify'

# require the core functionality
require 'meshchat'

# additional functionality
require 'spiced_rumby/version'
require 'spiced_rumby/cli_input'
require 'spiced_rumby/cli_output'
require 'spiced_rumby/notifier'

module SpicedRumby
  NAME = 'Spiced Rumby'

  require 'spiced_rumby/vedeu_test'

  module_function

  def start
    MeshChat.start(
      client_name: NAME,
      client_version: VERSION,
      display: VedeuTest::Controllers::ChatOutput, #CLIOutput,
      input: CLIInput,
      notifier: Notifier,
      on_display_start: ->{ MeshChat::CLI.check_startup_settings }
    )
  end
end
