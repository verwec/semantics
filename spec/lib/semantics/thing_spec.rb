require 'spec_helper'

describe Semantics::Thing do
  describe '#find' do

    let(:cp_id) { 4591 }
    let(:obj_id) { 28653 }
    let(:thing) do
      VCR.use_cassette('get_thing') do
        Semantics::Thing.find(cp_id, obj_id)
      end
    end
    subject { thing }

    describe 'the found thing' do
      its('generated_text') { is_expected.to include "Wer ist" }
      its('status') { is_expected.to eq "success" }
      its('created') { is_expected.to be }
      its('modified') { is_expected.to be }
      its('uid') { is_expected.to eq '214' }
      its('name') { is_expected.to eq 'value2' }
      its('text_as_html') { is_expected.to include 'Wer ist' }
      its('pure_data') { is_expected.to eq({"name"=>"name"}) }
      its('content_project') { is_expected.to eq 4591 }
    end
  end

  describe '#create' do
    it 'creates a thing' do
      VCR.use_cassette('create_thing') do
        cp_id = 4591
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
        cp_id = 4591
        uid = 214
        name = 'foobar'
        pure_date = { name: 'Bob' }
        obj_id = 28653
        thing = Semantics::Thing.update(cp_id, obj_id, uid, name, pure_date)
        expect(thing.name).to eq('foobar')
      end
    end
  end
end
