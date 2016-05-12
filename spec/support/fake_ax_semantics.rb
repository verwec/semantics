require 'sinatra/base'

class FakeAxSemantics < Sinatra::Base
  # login
  post '/v1/rest-auth/login/' do
    json_response 200, 'login.json'
  end

  # content_projects
  get '/v1/content-project/' do
    json_response 200, 'content_projects.json'
  end

  get '/v1/content-project/:id/' do
    json_response 200, 'content_project.json'
  end

  post '/v1/content-project/' do
    json_response 201, 'content_project.json'
  end

  # things
  get '/v1/allthings/' do
    json_response 200, 'things.json'
  end

  get '/v1/content-project/123/thing/1/' do
    json_response 200, 'thing.json'
  end

  get '/v1/content-project/123/thing//' do
    json_response 404
  end

  post '/v1/content-project/123/thing/' do
    json_response 201, 'thing.json'
  end

  put '/v1/content-project/123/thing/1/' do
    json_response 200, 'updated_thing.json'
  end

  post '/v1/content-project/123/thing/1/generate_content/' do
    json_response 200, 'generate_content.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
