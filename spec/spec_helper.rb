$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'semantics'
require 'rspec/its'
require 'webmock/rspec'
require 'pry'
require './spec/support/fake_ax_semantics'

WebMock.disable_net_connect!(allow_localhost: true)

Semantics.configure do |config|
  config.api_token = 'Token 1234'.freeze
end

RSpec.configure do |config|
  def headers
    {
      Authorization: 'Token 1234',
      'Content-Type' => 'application/json'
    }
  end
end
