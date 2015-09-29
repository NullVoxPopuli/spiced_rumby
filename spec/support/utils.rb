def mock_settings_objects
  delete_test_files

  allow_any_instance_of(SpicedGracken::Config::ServerList).to receive(:filename) { 'test-serverlist' }
  sl = SpicedGracken::Config::ServerList.new
  allow(SpicedGracken::Config::ServerList).to receive(:instance) { sl }

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
  File.delete('test-serverlist') if File.exist?('test-serverlist')
  File.delete('test-hashfile') if File.exist?('test-hashfile')
  File.delete('test-settings') if File.exist?('test-settings')
  File.delete('test-activeserverlist') if File.exist?('test-activeserverlist')
end
