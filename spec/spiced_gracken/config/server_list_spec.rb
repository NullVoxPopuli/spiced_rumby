require 'spec_helper'

describe SpicedGracken::Config::ServerList do
  let(:klass) { SpicedGracken::Config::ServerList }
  let(:server_list) { klass.new }
  let(:active) do
    [
      {
        'alias' => 'evan',
        'address' => 'something:80',
        'uid' => '1',
        'publicKey' => '123'

      },
      {
        'alias' => 'preston',
        'address' => 'somethingelse:82',
        'uid' => '2',
        'publicKey' => '123'

      }
    ]
  end

  before(:each) do
    allow_any_instance_of(klass).to receive(:filename) { 'test-serverlist' }
  end

  describe '#as_entries' do
    it 'is empty' do
      expect(server_list.as_entries).to be_empty
    end

    it 'returns entries' do
      server_list.clear!
      server_list.servers = active

      expected = [
        SpicedGracken::Config::Entry.new(
          alias_name: 'evan',
          address: 'something:80',
          uid: '1',
          public_key: '123'
        ).as_json,
        SpicedGracken::Config::Entry.new(
          alias_name: 'preston',
          address: 'somethingelse:82',
          uid: '2',
          public_key: '123'
        ).as_json
      ]

      entries = server_list.as_entries.map(&:as_json)

      expect(entries).to include(expected.first)
      expect(entries).to include(expected.last)
    end
  end

  context 'servers' do
    it 'gets the active servers when empty' do
      result = server_list.servers

      expect(result).to eq []
    end
  end

  context 'clear' do
    before(:each) do
      server_list._hash = {
        'servers' => [
          {
            'alias' => 'name',
            'address' => '10.10.10.10:10010'
          }
        ]
      }
    end

    it 'clears the main hash' do
      server_list.clear!

      expect(server_list._hash).to eq('servers' => [])
    end
  end
end
