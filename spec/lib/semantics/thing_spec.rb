require 'spec_helper'

describe Semantics::Thing do
  describe '#find' do
    it 'returns a thing' do
      cp_id = 4591
      obj_id = 28654
      thing = Semantics::Thing.find(cp_id, obj_id)
      expect(thing.generated_text).to include 'Welche Leistungen bietet'
    end
  end

  describe '#create' do
    it 'creates a thing' do
      cp_id = 4591
      uid = 112343
      name = 'foobar'
      pure_date = { key: 'value' }
      thing = Semantics::Thing.create(cp_id, uid, name, pure_date)
      expect(thing.name).to eq(name)
    end
  end
end
