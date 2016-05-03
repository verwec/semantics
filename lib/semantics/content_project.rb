module Semantics
  class ContentProject
    include HTTParty

    base_uri BASE_URI

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def self.find(cp_id)
      endpoint = "/content-project/#{cp_id}/"
      options = { headers: headers }
      attributes = get(endpoint, options)
      raise ApiError.new(attributes) unless attributes.response.code == '200'
      new(attributes)
    end

    def self.create(name, engine_configuration)
      endpoint = '/content-project/'
      options = {
        headers: headers,
        body: {
          name: name,
          engine_configuration: engine_configuration
        }.to_json
      }
      attributes = post(endpoint, options)
      raise ApiError.new(attributes) unless attributes.response.code == '201'
      new(attributes)
    end

    def self.headers
      {
        'Content-Type' => 'application/json',
        'Authorization' => TOKEN
      }
    end

    def method_missing(method)
      data[method.to_s]
    end
  end
end
