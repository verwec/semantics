require 'spec_helper'

describe Semantics::Login do
  describe '.get_token' do
    it 'returns a token' do
      user = 'demo'
      password = '123456'
      VCR.use_cassette('get_token') do
        expect(Semantics::Login.get_token(user, password)).to eq 'aa5d2e36668c11e5964038bc572ec103'
      end
    end
  end
end
