require 'openssl'
require 'socket'
require 'json'
require 'date'
require 'colorize'
require 'curses'
require 'io/console'
require "readline"

require 'logger'

require 'awesome_print'
require 'sqlite3'
require 'active_record'
require 'curb'
require 'thin'


require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/object/try'

require 'spiced_gracken/version'
require 'spiced_gracken/encryption'
require 'spiced_gracken/display'
require 'spiced_gracken/display/manager'
require 'spiced_gracken/models/entry'
require 'spiced_gracken/config/hash_file'
require 'spiced_gracken/config/settings'
require 'spiced_gracken/net/request'
require 'spiced_gracken/net/client'
require 'spiced_gracken/net/listener/request'
require 'spiced_gracken/net/listener/request_processor'
require 'spiced_gracken/net/listener/server'
require 'spiced_gracken/cli'
require 'spiced_gracken/message'


module SpicedGracken
  NAME = 'Spiced Gracken'

  Settings = Config::Settings
  Node = Models::Entry
  Cipher = Encryption

  module_function

  def start(selected_ui)
    # select the specified interface.
    # default is Display::Bash::UI
    #
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
      CLI.check_startup_settings
    end
  end

  def ui
    @@display
  end

  def self.setup_storage
    ActiveRecord::Base.establish_connection(
        adapter: "sqlite3",
        database: "dev.sqlite3",
        pool: 128
    )

    ActiveRecord::Migration.suppress_messages do
      ActiveRecord::Schema.define do
        unless table_exists? :entries
          create_table :entries do |table|
            table.column :alias_name, :string
            table.column :location, :string
            table.column :uid, :string
            table.column :public_key, :string
            table.column :online, :boolean
          end
        end
      end
    end
  end
end

SpicedGracken.setup_storage
