$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'semantics'
require 'rspec/its'
require 'webmock/rspec'
require './spec/support/fake_ax_semantics'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    stub_request(:any, 'https://api.ax-semantics.com/v1/rest-auth/login/').to_rack(FakeAxSemantics)
  end
end
