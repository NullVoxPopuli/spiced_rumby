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
    allow_any_instance_of(klass).to receive(:filename) { 'test-serverlist' }
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
