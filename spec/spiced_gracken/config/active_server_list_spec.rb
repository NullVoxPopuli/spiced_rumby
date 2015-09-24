require 'spec_helper'

describe SpicedGracken::Config::ActiveServerList do
  let(:klass){ SpicedGracken::Config::ActiveServerList }
  let(:list){ klass.new }

  before(:each) do
    allow(SpicedGracken).to receive(:server_list) do
      SpicedGracken::Config::ServerList.new
    end
  end

  context 'as_array' do
    it 'gets the active servers' do
      list._list = expected = [
        {}, {}, {}
      ]
      result = list.as_array
      expect(result).to eq expected
    end
  end

  context 'clear' do
    it 'clears the list' do
      list._list = [12]
      list.clear!

      expect(list._list).to eq []
    end
  end

  context 'remove' do
    before(:each) do
      list._list = [
        SpicedGracken::Config::Entry.new(
          address: '10.10.10.10:1010',
          alias_name: 'test',
          uid: '1234',
          public_key: 'abcde'
        )
      ]
    end

    it 'removes an entry by address' do
      list.remove(address: '10.10.10.10:1010')
      expect(list.count).to eq 0
    end

    it 'removes an entry by alias' do
      list.remove(alias_name: 'test')
      expect(list.count).to eq 0
    end

    it 'removes an entry by uid' do
      list.remove(uid: '1234')
      expect(list.count).to eq 0
    end

    it 'does not remove non existant' do
      list.remove(address: 'wut')
      expect(list.count).to eq 1
    end
  end

  context 'add' do

  end

  context 'update' do

  end

  context 'contains?' do

  end

end
