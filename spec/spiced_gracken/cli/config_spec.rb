require 'spec_helper'

describe SpicedGracken::CLI::Config do
  let (:klass){ SpicedGracken::CLI::Config }

  before(:each) do
    mock_settings_objects
  end

  describe '#handle' do
    context 'set' do
      it 'sets the value' do
        c = klass.new('/config set anything toValue')
        c.handle
        expect(SpicedGracken::Settings['anything']).to eq 'toValue'
      end

      it 'does not pass valid params' do
        c = klass.new('/config set')
        expect(c.handle).to eq 'set requires a key and a value'
      end
    end

    context 'display' do
      it 'displays the settings' do
        c = klass.new('/config display')
        expect(c.handle).to eq SpicedGracken::Settings.display
      end
    end

    it 'does not recognize the command' do
      c = klass.new('/config nope')
      expect(c.handle).to eq 'config command not implemented...'
    end
  end

  describe '#config_set_args' do
    it 'returns the last two args' do
      c = klass.new('/config set arg1 arg2')
      expect(c.config_set_args).to eq ['arg1', 'arg2']
    end
  end

  describe '#is_valid_set_command?' do
    it 'requires the subcommand to be set' do
      c = klass.new('/config wat')
      expect(c.is_valid_set_command?).to eq false
    end

    it 'requires is false if less than 4 arguments' do
      c = klass.new('/config set hello')
      expect(c.is_valid_set_command?).to eq false
    end

    it 'requires all arguments' do
      c = klass.new('/config set hello there')
      expect(c.is_valid_set_command?).to eq true
    end

  end

end
