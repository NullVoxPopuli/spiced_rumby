def mock_settings_objects
  sl = SpicedGracken::Config::ServerList.new
  allow_any_instance_of(SpicedGracken::Config::ServerList).to receive(:filename) { 'test-serverlist' }
  allow(SpicedGracken).to receive(:server_list) { sl }

  s = SpicedGracken::Config::Settings.new
  allow_any_instance_of(SpicedGracken::Config::Settings).to receive(:filename) { 'test-settings' }
  allow(SpicedGracken).to receive(:settings) { s }

  asl = SpicedGracken::Config::ActiveServerList.new
  allow(SpicedGracken).to receive(:active_server_list) { asl }

  null = SpicedGracken::Display::Null::UI.new
  allow(SpicedGracken).to receive(:ui){ null }
  allow(SpicedGracken).to receive(:display){ null }
end
