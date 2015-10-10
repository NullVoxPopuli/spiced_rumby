require 'spec_helper'

describe SpicedGracken::Config::ActiveServerList do
  let(:klass) { SpicedGracken::Config::ActiveServerList }

  before(:each) do
    klass.clear!
  end

  context 'as_array' do
    it 'gets the active servers' do
      klass.instance._list = expected = [
        {}, {}, {}
      ]
      result = klass.instance.as_array
      expect(result).to eq expected
    end
  end

  context 'clear' do
    it 'clears the list' do
      klass.instance._list = [12]
      klass.clear!

      expect(klass.instance._list).to eq []
    end
  end

  context 'remove' do
    let(:entry) do
      SpicedGracken::Models::Entry.new(
        location: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde')
    end

    before(:each) do
      klass.instance._list = [entry]
    end

    it 'removes an entry by location' do
      klass.remove(location: entry.location)
      expect(klass.count).to eq 0
    end

    it 'removes an entry by alias' do
      klass.remove(alias_name: entry.alias_name)
      expect(klass.count).to eq 0
    end

    it 'removes an entry by uid' do
      klass.remove(uid: entry.uid)
      expect(klass.count).to eq 0
    end

    it 'does not remove non existant' do
      klass.remove(location: 'wut')
      expect(klass.count).to eq 1
    end
  end

  context 'add' do
    it 'adds an entry' do
      SpicedGracken::Models::Entry.destroy_all

      entry = {
        'location' => '10.10.10.10:1010',
        'alias' => 'test',
        'uid' => '1234',
        'publicKey' => 'abcde'
      }
      e = SpicedGracken::Models::Entry.from_json(entry)
      klass.add(entry: e)

      expect(klass.count).to eq 1
      expect(klass.first.as_json).to eq entry
    end

    it 'updates an existing entry' do
      SpicedGracken::Models::Entry.destroy_all

      entry = SpicedGracken::Models::Entry.new(
        location: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde'
      )

      klass.add(uid: entry.uid, entry: entry)

      entry.alias_name = 'test2'
      klass.add(uid: entry.uid, entry: entry)

      expect(klass.count).to eq 1
      expect(klass.first.alias_name).to eq 'test2'
    end
  end

  context 'update' do
    let(:entry) do
      SpicedGracken::Models::Entry.new(
        location: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde')
    end

    before(:each) do
      klass.add(entry: entry)
    end

    it 'updates the location' do
      klass.update('1234', location: '1.1.1.1:11')
      expect(klass.first.location).to eq '1.1.1.1:11'
    end

    it 'updates the alias' do
      klass.update('1234', alias_name: 'test2')
      expect(klass.first.alias_name).to eq 'test2'
    end
  end

  context 'contains?' do
    let(:entry) do
      SpicedGracken::Models::Entry.new(
        location: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde')
    end

    before(:each) do
      klass.add(entry: entry)
    end

    it 'finds by alias' do
      result = klass.find(alias_name: 'test')
      expect(result).to eq entry
    end

    it 'finds by location' do
      result = klass.find(location: '10.10.10.10:1010')
      expect(result).to eq entry
    end

    it 'finds by uid' do
      result = klass.find(uid: '1234')
      expect(result).to eq entry
    end

    it 'does not find' do
      result = klass.find(location: 'fake')
      expect(result).to eq nil
    end
  end

  describe '#find_all' do
    it 'finds no one' do
      expect(klass.find_all).to be_empty
    end

    context 'servers exist' do
      let(:entry) do
        SpicedGracken::Models::Entry.new(
          location: '10.10.10.10:1010',
          alias_name: 'test',
          uid: '1234',
          public_key: 'abcde')
      end

      before(:each) do
        klass.instance._list = [entry, entry]
      end

      it 'finds multiple' do
        result = klass.find_all(alias_name: 'test').count
        expect(result).to eq 2
      end
    end
  end

  describe '#save' do
    it 'saves' do
      entry =   SpicedGracken::Models::Entry.new(
          location: '10.10.10.10:1010',
          alias_name: 'test',
          uid: '1234',
          public_key: 'abcde')

      klass.instance._list = [entry]

      expect{
        klass.save
      }.to change(SpicedGracken::Models::Entry, :count).by 1
    end
  end

  describe '#display_locations' do

    it 'shows no one is online' do
      expect(klass.display_locations).to eq 'no active nodes'
    end

    it 'shows who is online' do
      entry = SpicedGracken::Models::Entry.new(
        location: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde')

      klass.instance._list = [entry]

      expect(klass.display_locations).to eq 'test@10.10.10.10:1010'
    end
  end

  describe '#who' do

    it 'shows no one is online' do
      expect(klass.who).to eq 'no one is online'
    end

    it 'shows who is online' do
      entry = SpicedGracken::Models::Entry.new(
        location: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde')

      klass.instance._list = [entry]

      expect(klass.who).to eq 'test'
    end
  end

  describe '#remove_by' do
    let(:entry) do
      SpicedGracken::Models::Entry.new(
        location: '10.10.10.10:1010',
        alias_name: 'test',
        uid: '1234',
        public_key: 'abcde')
    end

    before(:each) do
      klass.instance._list = [entry]
    end

    it 'removes an entry by location' do
      klass.remove_by('location', entry.location)
      expect(klass.count).to eq 0
    end

    it 'removes an entry by alias' do
      klass.remove_by('alias', entry.alias_name)
      expect(klass.count).to eq 0
    end

    it 'removes an entry by uid' do
      klass.remove_by('uid', entry.uid)
      expect(klass.count).to eq 0
    end

    it 'does not remove non existant' do
      klass.remove_by('location', 'wut')
      expect(klass.count).to eq 1
    end
  end
end
