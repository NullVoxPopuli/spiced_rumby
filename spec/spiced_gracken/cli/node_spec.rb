require 'spec_helper'

describe SpicedGracken::CLI::Node do
  let (:klass){ SpicedGracken::CLI::Node }

  before(:each) do
    mock_settings_objects
  end


  describe '#handle' do
    it 'alerts the user' do
      # don't actually shut down...
      expect(SpicedGracken::Models::Entry).to receive(:first)
      c = klass.new('/node first')
      c.handle
    end
  end

end
