require 'spec_helper'

describe SpicedGracken::CLI::StopListening do
  let (:klass){ SpicedGracken::CLI::StopListening }

  before(:each) do
    mock_settings_objects
  end


  describe '#handle' do
    it 'alerts the user' do
      c = klass.new('/stoplistening')
      expect(c.handle).to eq nil
    end
  end

end
