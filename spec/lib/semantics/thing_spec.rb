require 'spec_helper'

describe Semantics::Thing do
  let(:cp_id) { 4748 }
  let(:obj_id) { 93_685 }

  describe '#all' do
    it 'lists all things' do
      VCR.use_cassette('all_content_projects') do
        expect(Semantics::Thing.all(cp_id).count).to be > 0
      end
    end
  end

  describe '#find' do
    let(:thing) do
      VCR.use_cassette('get_thing') do
        Semantics::Thing.find(cp_id, obj_id)
      end
    end
    subject { thing }

    describe 'the found thing' do
      its('status') { is_expected.to eq 'not requested' }
      its('created') { is_expected.to be }
      its('modified') { is_expected.to be }
      its('uid') { is_expected.to be }
      its('name') { is_expected.to eq 'foobar' }
      its('pure_data') { is_expected.to eq('key' => 'value') }
      its('content_project') { is_expected.to eq cp_id }
    end

    it 'throws an appropriated error' do
      VCR.use_cassette('get_thing_error') do
        expect { Semantics::Thing.find(1, nil) }.to raise_error Semantics::ApiError
      end
    end
  end

  describe '#create' do
    it 'creates a thing' do
      VCR.use_cassette('create_thing') do
        uid = Time.now.to_s
        name = 'foobar'
        pure_date = { key: 'value' }
        thing = Semantics::Thing.create(cp_id, uid, name, pure_date)
        expect(thing.name).to eq(name)
      end
    end
  end

  describe '#update' do
    it 'updates a thing' do
      VCR.use_cassette('update_thing') do
        name = 'foobar'
        uid = 214
        pure_date = { name: 'Bob' }
        thing = Semantics::Thing.update(cp_id, obj_id, uid, name, pure_date)
        expect(thing.name).to eq(name)
      end
    end
  end

  describe '#generate_content' do
    it 'generates content for a single object' do
      VCR.use_cassette('generate_content') do
        response = Semantics::Thing.generate_content(cp_id, obj_id)
        expect(response).to eq 'NOT_CALLED'
      end
    end
  end
end
