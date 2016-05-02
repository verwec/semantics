module Semantics
  class ContentProject
    include HTTParty

    base_uri BASE_URI

    attr_reader :id, :name, :axcompany_name, :engine_configuration,
                :count_things, :count_generated_texts, :thing_type

    def initialize(attributes)
      @id = attributes['id']
      @name = attributes['name']
      @axcompany_name = attributes['axcompany_name']
      @engine_configuration = attributes['engine_configuration']
      @count_things = attributes['count_things']
      @count_generated_texts = attributes['count_generated_texts']
      @thing_type = attributes['thing_type']
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
      raise ApiError.new(attributes) unless attributes.response.code == '200'
      new(attributes)
    end

    def self.headers
      {
        'Content-Type' => 'application/json',
        'Authorization' => TOKEN
      }
    end
  end
end
