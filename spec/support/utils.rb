def mock_settings_objects
  sl = SpicedGracken::Config::ServerList.new
  allow_any_instance_of(SpicedGracken::Config::ServerList).to receive(:filename) { 'test-serverlist' }
  allow(SpicedGracken::Config::ServerList).to receive(:instance) { sl }

  s = SpicedGracken::Config::Settings.new
  allow_any_instance_of(SpicedGracken::Config::Settings).to receive(:filename) { 'test-settings' }
  allow(SpicedGracken::Config::Settings).to receive(:instance) { s }

  asl = SpicedGracken::Config::ActiveServerList.new
  allow(SpicedGracken::Config::ActiveServerList).to receive(:instance) { asl }

  display_manager = SpicedGracken::Display::Manager.new(
    SpicedGracken::Display::Null::UI
  )
  allow(SpicedGracken).to receive(:ui){ display_manager }
end
