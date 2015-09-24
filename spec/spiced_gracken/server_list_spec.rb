require 'spec_helper'

describe SpicedGracken::ServerList do
  let(:klass){ SpicedGracken::ServerList }
  let(:server_list){ klass.new }
  let(:active){
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
  }

  before(:each) do
    allow_any_instance_of(klass).to receive(:filename){ 'blegh' }
    allow_any_instance_of(klass).to receive(:save){}
  end

  context 'servers' do
    it 'gets the active servers when empty' do
      result = server_list.servers

      expect(result).to eq []
    end

    it 'gets the active servers' do
      server_list._active_servers = expected = [
        {}, {}, {}
      ]
      result = server_list.servers
      expect(result).to eq expected
    end
  end

  context 'inactive!' do

  end

  context 'add' do
    it 'add without alias' do
      server_list.clear!
      server_list.add('10.10.0.1:8080')

      result = server_list.servers
      expected = [
        {
          alias: '',
          address: '10.10.0.1:8080'
        }
      ]

      expect(result).to eq expected
    end

    it 'add with alias' do
      server_list.add('10.10.0.1:8080', 'test')
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
