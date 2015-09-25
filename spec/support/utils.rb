def mock_settings_objects
  sl = SpicedGracken::Config::ServerList.new
  allow_any_instance_of(SpicedGracken::Config::ServerList).to receive(:filename) { 'test-serverlist' }
  allow(SpicedGracken).to receive(:server_list) do
    sl
  end

  s = SpicedGracken::Config::Settings.new
  allow_any_instance_of(SpicedGracken::Config::Settings).to receive(:filename) { 'test-settings' }
  allow(SpicedGracken).to receive(:settings) do
    s
  end

  asl = SpicedGracken::Config::ActiveServerList.new
  allow(SpicedGracken).to receive(:active_server_list) do
    asl
  end
end
