require 'spec_helper'

describe SpicedGracken::Config::ActiveServerList do
  let(:klass) { SpicedGracken::Config::ActiveServerList }
  let(:list) { klass.new }

  before(:each) do
    allow_any_instance_of(klass).to receive(:load) {}
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
  end

  context 'contains?' do
  end
end
