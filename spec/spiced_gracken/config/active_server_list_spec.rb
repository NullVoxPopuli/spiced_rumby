require 'spec_helper'

describe SpicedGracken::Config::ActiveServerList do
  let(:klass) { SpicedGracken::Config::ActiveServerList }
  let(:list) { klass.new }

  before(:each) do
    allow_any_instance_of(SpicedGracken::Config::ServerList).to receive(:filename) { 'test-serverlist' }
    allow(SpicedGracken).to receive(:server_list) do
      SpicedGracken::Config::ServerList.new
    end

    list.clear!
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
    let(:entry) do
      SpicedGracken::Config::Entry.new(
        address: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde')
    end

    before(:each) do
      list._list = [entry]
    end

    it 'removes an entry by address' do
      list.remove(address: entry.address)
      expect(list.count).to eq 0
    end

    it 'removes an entry by alias' do
      list.remove(alias_name: entry.alias_name)
      expect(list.count).to eq 0
    end

    it 'removes an entry by uid' do
      list.remove(uid: entry.uid)
      expect(list.count).to eq 0
    end

    it 'does not remove non existant' do
      list.remove(address: 'wut')
      expect(list.count).to eq 1
    end
  end

  context 'add' do
    it 'adds an entry' do
      entry = {
        address: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde'
      }
      list.add(entry)

      expect(list.count).to eq 1
      expect(list.first.attributes).to eq entry
    end

    it 'updates an existing entry' do
      entry = SpicedGracken::Config::Entry.new(
        address: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde'
      )

      list.add(uid: entry.uid, entry: entry)

      entry.alias_name = 'test2'
      list.add(uid: entry.uid, entry: entry)

      expect(list.count).to eq 1
      expect(list.first.alias_name).to eq 'test2'
    end
  end

  context 'update' do
    let(:entry) do
      SpicedGracken::Config::Entry.new(
        address: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde')
    end

    before(:each) do
      list.add(entry: entry)
    end

    it 'updates the address' do
      list.update('1234', address: '1.1.1.1:11')
      expect(list.first.address).to eq '1.1.1.1:11'
    end

    it 'updates the alias' do
      list.update('1234', alias_name: 'test2')
      expect(list.first.alias_name).to eq 'test2'
    end
  end

  context 'contains?' do
    let(:entry) do
      SpicedGracken::Config::Entry.new(
        address: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde')
    end

    before(:each) do
      list.add(entry: entry)
    end

    it 'finds by alias' do
      result = list.find(alias_name: 'test')
      expect(result).to eq entry
    end

    it 'finds by address' do
      result = list.find(address: '10.10.10.10:1010')
      expect(result).to eq entry
    end

    it 'finds by uid' do
      result = list.find(uid: '1234')
      expect(result).to eq entry
    end

    it 'does not find' do
      result = list.find(address: 'fake')
      expect(result).to eq nil
    end
  end
end
