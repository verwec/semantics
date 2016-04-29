module Semantics
  class Thing
    include HTTParty

    attr_reader :id, :generated_text, :name

    def initialize(attributes)
      @id = attributes["id"]
      @generated_text = attributes["generated_text"]
      @name = attributes["name"]
    end

    def self.find(cp_id, obj_id)
      endpoint = "https://api.ax-semantics.com/v1/content-project/#{cp_id}/thing/#{obj_id}"
      options = { headers: headers }
      attributes = get(endpoint, options)
      new(attributes)
    end

    def self.create(cp_id, uid, name, pure_data)
      endpoint = "https://api.ax-semantics.com/v1/content-project/#{cp_id}/thing/"
      options = {
        headers: headers,
        body: {
          uid: Time.now.to_s,
          name: name,
          content_project: cp_id,
          pure_data: pure_data
        }.to_json
      }
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
