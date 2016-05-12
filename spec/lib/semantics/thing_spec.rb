require 'spec_helper'

describe Semantics::Thing do
  let(:cp_id) { 123 }
  let(:obj_id) { 1 }

  describe '.all' do
    it 'lists all things' do
      things = Semantics::Thing.all(cp_id)
      expect(things.count).to eq(1)
      expect(things.first).to be_kind_of(Semantics::Thing)
    end
  end

  describe '.find' do
    subject { Semantics::Thing.find(cp_id, obj_id) }

    describe 'the found thing' do
      its('status') { is_expected.to eq 'not requested' }
      its('created') { is_expected.to eq '2016-05-02T09:19:07.172345Z' }
      its('modified') { is_expected.to eq '2016-05-02T09:19:07.172636Z' }
      its('uid') { is_expected.to eq '123' }
      its('name') { is_expected.to eq 'foobar' }
      its('pure_data') { is_expected.to eq('key' => 'value') }
      its('content_project') { is_expected.to eq cp_id }
    end

    it 'can throw an appropriated error' do
      expect do
        Semantics::Thing.find(1, nil)
      end.to raise_error Semantics::ApiError
    end
  end

  describe '.create' do
    it 'creates a thing' do
      uid = 1
      pure_data = { key: 'value' }
      name =  'foobar'
      thing = Semantics::Thing.create(cp_id, uid, name, pure_data)
      expect(thing).to be_kind_of(Semantics::Thing)
    end
  end

  context "Update methods" do

    let(:name) { 'BobDoe' }
    let(:pure_data) { { 'name' => 'Bob Doe' } }
    let(:uid) { 99 }

    describe '#update' do
      it 'updates a thing' do
        thing = Semantics::Thing.find(cp_id, obj_id)
        updated_thing = thing.update(uid, name, pure_data)
        expect(updated_thing).to be_kind_of(Semantics::Thing)
      end
    end

    describe '.update' do
      it 'updates a thing' do
        updated_thing = Semantics::Thing.update(cp_id, obj_id, uid, name, pure_data)
        expect(updated_thing).to be_kind_of(Semantics::Thing)
      end
    end
  end

  describe '.generate_content' do
    it 'generates content' do
      status = Semantics::Thing.generate_content(cp_id, obj_id)
      expect(status).to eq 'SUCCESS'
    end
  end
end
