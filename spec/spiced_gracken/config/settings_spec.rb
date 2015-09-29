require 'spec_helper'

describe SpicedGracken::Config::Settings do
  let(:klass) { SpicedGracken::Config::Settings }

  before(:each) do
    allow_any_instance_of(SpicedGracken::Config::Settings).to receive(:filename) { 'test-settings' }
  end

  it 'sets the default if there is no settings file' do
    allow_any_instance_of(klass).to receive(:exists?) { false }

    expect(klass.new.as_hash).to eq klass::DEFAULT_SETTINGS
  end

  it 'sets the default if there is a settings file' do
    expect(klass.new.as_hash).to eq klass::DEFAULT_SETTINGS
  end

  context 'instance' do
    let(:i){ klass.new }

    describe '#valid?' do
      before(:each) do
        i._hash = {}
      end

      it 'is valid' do
        allow(i).to receive(:errors){ [] }
        expect(i).to be_valid
      end

      it 'is not valid' do
        expect(i).to_not be_valid
      end
    end

    describe '#errors' do

      it 'must have an alias' do
        i['alias'] = nil
        expect(i.errors).to include('must have an alias')
      end

      it 'must have ip set' do
        i['ip'] = nil
        expect(i.errors).to include('must have ip set')
      end

      it error = 'must have port set' do
        i['port'] = nil
        expect(i.errors).to include('must have port set')
      end

      it error = 'must have uid set' do
        i['uid'] = nil
        expect(i.errors).to include('must have uid set')
      end
    end
  end
end
