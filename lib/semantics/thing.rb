module Semantics
  class Thing
    include HTTParty

    attr_reader :id, :generated_text

    def initialize(attributes)
      @id = attributes["id"]
      @generated_text = attributes["generated_text"]
    end

    def self.find(cp_id, obj_id)
      endpoint = "https://api.ax-semantics.com/v1/content-project/#{cp_id}/thing/#{obj_id}"
      options = { headers: headers }
      attributes = get(endpoint, options)
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
