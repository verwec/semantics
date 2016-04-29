require 'spec_helper'

describe Semantics::Thing do
  describe '#find' do
    it 'returns a thing' do
      VCR.use_cassette('get_thing') do
        cp_id = 4591
        obj_id = 28653
        thing = Semantics::Thing.find(cp_id, obj_id)
        expect(thing.generated_text).to include 'Wer ist "Sparda-Bank Hamburg"?'
      end
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
