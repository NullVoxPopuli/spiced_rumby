require 'spec_helper'

describe SpicedGracken::Config::ServerList do
  let(:klass) { SpicedGracken::Config::ServerList }
  let(:server_list) { klass.new }
  let(:active) do
    [
      {
        'name' => 'evan',
        'address' => 'something:80'
      },
      {
        'name' => 'preston',
        'address' => 'somethingelse:82'
      }
    ]
  end

  before(:each) do
    allow_any_instance_of(klass).to receive(:filename) { 'blegh' }
    allow_any_instance_of(klass).to receive(:save) {}
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

  context 'inactive!' do
  end

  context 'add' do
    before(:each) do
      server_list.clear!
    end

    it 'add without alias' do
      server_list.add(SpicedGracken::Config::Entry.new(
                        address: '10.10.0.1:8080'
      ))
      result = server_list.servers
      expected = [
        {
          alias: '',
          address: '10.10.0.1:8080',
          uid: '',
          publicKey: ''
        }
      ]

      expected = JSON.parse(expected.to_json)

      expect(result).to eq expected
    end

    it 'add with alias' do
      server_list.add(SpicedGracken::Config::Entry.new(
                        alias_name: 'test',
                        address: '10.10.0.1:8080'
      ))

      result = server_list.servers
      expected = [
        {
          alias: 'test',
          address: '10.10.0.1:8080',
          uid: '',
          publicKey: ''
        }
      ]

      expected = JSON.parse(expected.to_json)

      expect(result).to eq expected
    end

    it 'does not add duplicates' do
      entry = SpicedGracken::Config::Entry.new(
        address: '10.10.0.1:8000'
      )
      server_list.add(entry)
      server_list.add(entry)

      expect(server_list.servers.count).to eq 1
    end
  end

  context 'remove_by' do
  end

  context 'remove' do
  end

  context 'find_by' do
  end

  context 'server_exists?' do
  end
end
