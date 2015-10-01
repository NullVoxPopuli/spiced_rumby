require 'spec_helper'

describe SpicedGracken::CLI::Identity do
  let (:klass){ SpicedGracken::CLI::Identity }

  before(:each) do
    mock_settings_objects
  end


  describe '#handle' do
    it 'alerts the user' do
      c = klass.new('/identity')
      # there isn't really a beneficial way to test this,
      # but it does make sure that there are no errors
      expect(c.handle).to eq SpicedGracken::Settings.identity
    end
  end

end
