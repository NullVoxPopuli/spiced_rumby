require 'spec_helper'

describe SpicedGracken::CLI::Who do
  let (:klass){ SpicedGracken::CLI::Who }

  before(:each) do
    mock_settings_objects
  end


  describe '#handle' do
    it 'alerts the user' do
      c = klass.new('/who')
      expect(c.handle).to eq SpicedGracken::ActiveServers.who
    end
  end

end
