require 'spec_helper'

describe SpicedGracken::CLI do
  let(:klass) { SpicedGracken::CLI }


  before(:each) do
    mock_settings_objects
  end

  context 'initialize' do
    it 'does not error' do
      expect{
        result = klass.new
      }.to_not raise_error
    end
  end

  context 'listen_for_commands' do
    it 'creates an input' do
      cli = klass.new
      allow(cli).to receive(:get_input){ 'chat message' }
      expect_any_instance_of(SpicedGracken::CLI::Input).to receive(:handle){}
      cli.process_input
    end
  end
end
