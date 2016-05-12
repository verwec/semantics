require 'spec_helper'

describe Semantics::Login do
  before do
    stub_request(:post, 'https://api.ax-semantics.com/v1/rest-auth/login/')
      .with(headers: login_headers, body: login_body)
      .to_rack(FakeAxSemantics)
  end

  describe '.get_token' do
    it 'returns a token' do
      user = 'USER@EXAMPLE.COM'
      password = 'SECRET_PASSWORD'
      expect(Semantics::Login.get_token(user, password)).to eq '12345'
    end
  end
end

private

  def login_headers
    {
      'Content-Type' => 'application/json'
    }
  end


  def login_body
    {
      email: 'USER@EXAMPLE.COM',
      password: 'SECRET_PASSWORD'
    }
  end
