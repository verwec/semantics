module Semantics
  class ContentProject
    include HTTParty

    attr_reader :id, :name

    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
    end

    def self.find(cp_id)
      endpoint = "https://api.ax-semantics.com/v1/content-project/#{cp_id}/"
      options = { headers: headers }
      attributes = get(endpoint, options)
      new(attributes)
    end

    def self.create(name, engine_configuration)
      endpoint = "https://api.ax-semantics.com/v1/content-project/"
      # TODO: don't use string concatenation
      options = { headers: headers, body: '{ "name": "' + name + '", "engine_configuration": "' + engine_configuration.to_s + '" }' }
      attributes = post(endpoint, options)
      new(attributes)
    end

    def self.headers
      {
        "Content-Type" => "application/json",
        "Authorization" => TOKEN
      }
    end
  end
end
