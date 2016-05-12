$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'semantics'
require 'rspec/its'
require 'webmock/rspec'
require './spec/support/fake_ax_semantics'

WebMock.disable_net_connect!(allow_localhost: true)

Semantics::TOKEN = 'Token 1234'.freeze

RSpec.configure do |config|

  config.before(:each) do

    # login
    stub_request(:post, 'https://api.ax-semantics.com/v1/rest-auth/login/')
      .with(headers: login_headers, body: login_body)
      .to_rack(FakeAxSemantics)

    # content projects
    stub_request(:get, 'https://api.ax-semantics.com/v1/content-project/')
      .with(headers: headers)
      .to_rack(FakeAxSemantics)

    stub_request(:get, 'https://api.ax-semantics.com/v1/content-project/1/')
      .with(headers: headers)
      .to_rack(FakeAxSemantics)

    stub_request(:post, 'https://api.ax-semantics.com/v1/content-project/')
      .with(headers: headers, body: content_project_post_body)
      .to_rack(FakeAxSemantics)

    # things
    stub_request(:get, 'https://api.ax-semantics.com/v1/allthings/?content_project_pk=123&page_size=100000')
      .with(headers: headers)
      .to_rack(FakeAxSemantics)

    stub_request(:get, 'https://api.ax-semantics.com/v1/content-project/123/thing/1/')
      .with(headers: headers)
      .to_rack(FakeAxSemantics)

    stub_request(:get, 'https://api.ax-semantics.com/v1/content-project/1/thing//')
      .with(headers: headers)
      .to_rack(FakeAxSemantics)

    stub_request(:post, 'https://api.ax-semantics.com/v1/content-project/123/thing/')
      .with(headers: headers, body: thing_post_body)
      .to_rack(FakeAxSemantics)

    stub_request(:put, 'https://api.ax-semantics.com/v1/content-project/123/thing/1/')
      .with(headers: headers, body: thing_put_body)
      .to_rack(FakeAxSemantics)

    stub_request(:post, 'https://api.ax-semantics.com/v1/content-project/123/thing/1/generate_content/?force=true')
      .to_rack(FakeAxSemantics)
  end

  private

  def login_body
    {
      email: 'USER@EXAMPLE.COM',
      password: 'SECRET_PASSWORD'
    }
  end

  def thing_put_body
    {
      uid: 99,
      name: 'BobDoe',
      content_project: 123,
      pure_data: { name: 'Bob Doe' }
    }
  end

  def thing_post_body
    {
      uid: 1,
      name: 'foobar',
      content_project: 123,
      pure_data: { key: 'value' }
    }
  end

  def content_project_post_body
    {
      name: 'NEW_CP',
      engine_configuration: '123'
    }
  end

  def login_headers
    {
      'Content-Type' => 'application/json'
    }
  end

  def headers
    {
      Authorization: 'Token 1234',
      'Content-Type' => 'application/json'
    }
  end
end
