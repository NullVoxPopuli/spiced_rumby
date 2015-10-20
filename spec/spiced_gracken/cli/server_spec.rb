require 'spec_helper'

describe SpicedGracken::CLI::Server do
  let (:klass){ SpicedGracken::CLI::Server }

  before(:each) do
    mock_settings_objects
  end

  describe '#is_valid_add_command?' do
    it 'is valid' do
      c = klass.new('/servers add me@ip:port#uid')
      expect(c.is_valid_add_command?).to eq true
    end
  end

  describe '#is_valid_remove_command?' do
    it 'is valid' do
      c = klass.new('/server rm alias me')
      expect(c.is_valid_remove_command?).to eq true
    end

    it 'is valid the long way' do
      c = klass.new('/server remove alias me')
      expect(c.is_valid_remove_command?).to eq true
    end
  end


  describe '#handle' do

    it 'shows who is online' do
      c = klass.new('/server online')
      #expect(c.handle).to eq SpicedGracken::ActiveServers.display_locations
    end

    it 'lists the locations' do
      c = klass.new('/servers')
      #expect(c.handle).to eq SpicedGracken::ActiveServers.display_locations
    end


  end

end
