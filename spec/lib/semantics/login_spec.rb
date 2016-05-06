require 'spec_helper'

describe Semantics::Login do
  describe '.get_token' do
    it 'returns a token' do
      user = 'USER@EXAMPLE.COM'
      password = 'SECRET_PASSWORD'
      expect(Semantics::Login.get_token(user, password)).to eq '12345'
    end
  end
end
