require 'spec_helper'

describe SpicedGracken::CLI::Exit do
  let (:klass){ SpicedGracken::CLI::Exit }

  before(:each) do
    mock_settings_objects
  end


  describe '#handle' do
    it 'alerts the user' do
      # don't actually shut down...
      expect(SpicedGracken::CLI).to receive(:shutdown)
      c = klass.new('/exit')
      c.handle
    end
  end

end
