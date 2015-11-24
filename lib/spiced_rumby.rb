# helper gems
require 'libnotify'

# require the core functionality
require 'meshchat'

# additional functionality
require 'spiced_rumby/version'
require 'spiced_rumby/notifier'

module SpicedRumby
  NAME = 'Spiced Rumby'


  module_function

  def start
    is_debugging = ['nogui', 'bash', 'b', 'd', 'debug'].include?(ARGV.first)
    is_debugging ? debug_start : gui_start
  end

  def debug_start
    require 'spiced_rumby/debug/cli_input'
    require 'spiced_rumby/debug/cli_output'

    MeshChat.start(
      client_name: NAME,
      client_version: VERSION,
      display: Debug::CLIOutput,
      input: Debug::CLIInput,
      notifier: Notifier,
      on_display_start: ->{ MeshChat::CLI.check_startup_settings }
    )
  end

  def gui_start
    require 'bundler/setup'
    require 'vedeu'
    require 'spiced_rumby/gui'

    MeshChat.start(
      client_name: NAME,
      client_version: VERSION,
      display: GUI::MeshChatHook,
      input:  GUI::InputHook,
      notifier: Notifier,
      on_display_start: ->{ MeshChat::CLI.check_startup_settings }
    )
  end

end
