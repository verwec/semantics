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
end
