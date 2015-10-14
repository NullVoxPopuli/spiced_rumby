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
    context 'add' do
      it 'is not valid' do
        c = klass.new('/server add me')
        expect(c.handle).to eq 'add requires alias@ip:port#uid'
      end
      context 'is valid' do
        it 'adds to active servers' do
          c = klass.new('/server add me@1.2.3.4:1234#4321')

          expect{
            c.handle
          }.to change(SpicedGracken::ActiveServers, :count).by 1
        end
      end
    end

    context 'remove' do
      it 'is not valid' do
        c = klass.new('/server remove me')
        expect(c.handle).to eq 'requires location or alias. ex: /server rm alias evan'
      end
      context 'is valid' do
        it 'removes from active servers' do
          SpicedGracken::ActiveServers.instance._list = [
            SpicedGracken::Models::Entry.new(
              alias_name: 'me',
              location: '1.1.1.1:11',
              uid: '125',
              public_key: '00'
            )
          ]
          c = klass.new('/server rm alias me')
          expect{
            c.handle
          }.to change(SpicedGracken::ActiveServers, :count).by -1
        end
      end
    end

    context 'neither' do
      it 'is not recognized' do
        c = klass.new('/server wut')
        expect(c.handle).to eq SpicedGracken::ActiveServers.display_locations
      end

      it 'lists the locations' do
        c = klass.new('/servers')
        expect(c.handle).to eq SpicedGracken::ActiveServers.display_locations
      end


    end
  end

end
