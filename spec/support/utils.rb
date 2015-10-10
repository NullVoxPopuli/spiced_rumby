def mock_settings_objects
  delete_test_files

  setup_database

  allow(SpicedGracken::Cipher).to receive(:current_encryptor){
      SpicedGracken::Encryption::Passthrough
  }


  allow_any_instance_of(SpicedGracken::Config::Settings).to receive(:filename) { 'test-settings' }
  s = SpicedGracken::Config::Settings.new
  allow(SpicedGracken::Config::Settings).to receive(:instance) { s }

  asl = SpicedGracken::Config::ActiveServerList.new
  allow(SpicedGracken::Config::ActiveServerList).to receive(:instance) { asl }

  display_manager = SpicedGracken::Display::Manager.new(
    SpicedGracken::Display::Null::UI
  )
  allow(SpicedGracken).to receive(:ui){ display_manager }
end

def delete_test_files
  File.delete('test.sqlite3') if File.exist?('test.sqlite3')
  File.delete('test-hashfile') if File.exist?('test-hashfile')
  File.delete('test-settings') if File.exist?('test-settings')
  File.delete('test-activeserverlist') if File.exist?('test-activeserverlist')
end

def setup_database
  SpicedGracken::Models::Entry.destroy_all

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
        end
      end
    end
  end
end
