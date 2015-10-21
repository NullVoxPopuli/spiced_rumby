def mock_settings_objects
  delete_test_files

  setup_database

  allow(MeshChat::Cipher).to receive(:current_encryptor){
      MeshChat::Encryption::Passthrough
  }
  MeshChat::Cipher.instance_variable_set('@current_encryptor', MeshChat::Encryption::Passthrough)


  allow_any_instance_of(MeshChat::Config::Settings).to receive(:filename) { 'test-settings' }
  s = MeshChat::Config::Settings.new
  allow(MeshChat::Config::Settings).to receive(:instance) { s }


  display_manager = MeshChat::Display::Manager.new(
    MeshChatStub::Display::Null::UI
  )

  instance = MeshChat::Instance.new(
    client_name: MeshChat::NAME, # name of your client
    client_version: MeshChat::VERSION, # version of your client
    #display: MeshChatStub::Display::Null::UI, # your class of your implementation of `Display::Base`
    #on_display_start: ->{ MeshChat::CLI.check_startup_settings } # optional
  )
  MeshChat::Instance.instance_variable_set('@instance', instance)

  allow(instance).to receive(:start_ui){  }
  allow(instance).to receive(:display){ display_manager }
end

def delete_test_files
  begin
    File.delete('test.sqlite3') if File.exist?('test.sqlite3')
    File.delete('test-hashfile') if File.exist?('test-hashfile')
    File.delete('test-settings') if File.exist?('test-settings')
    File.delete('test-activeserverlist') if File.exist?('test-activeserverlist')
  rescue => e
    # I wonder if this would be a problem?
    ap e.message
  end
end

def setup_database
  # this method differs from the one defined on meshchat, in that
  # in destroys all nodes and uses an in-memory db

  ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3",
      :database  => ':memory:'
  )

  ActiveRecord::Migration.suppress_messages do
    ActiveRecord::Schema.define do
      unless table_exists? :entries
        create_table :entries do |table|
          table.column :alias_name, :string
          table.column :location, :string
          table.column :uid, :string
          table.column :public_key, :string
          table.column :online, :boolean, default: true, null: false
        end
      end
    end
  end

  # just to be sure
  MeshChat::Models::Entry.destroy_all
end
