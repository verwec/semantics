module Semantics
  class Thing
    include HTTParty

    attr_reader :id, :generated_text, :status, :created, :modified, :uid,
      :description, :name, :url, :text_as_html, :pure_data, :content_project, :name

    def initialize(attributes)
      @id = attributes["id"]
      @generated_text = attributes["generated_text"]
      @status = attributes["status"]
      @created = attributes["created"]
      @modified = attributes["modified"]
      @uid = attributes["uid"]
      @description = attributes["description"]
      @name = attributes["name"]
      @url = attributes["url"]
      @text_as_html = attributes["text_as_html"]
      @pure_data = attributes["pure_data"]
      @content_project = attributes["content_project"]
      @name = attributes["name"]
    end

    def self.find(cp_id, obj_id)
      endpoint = "#{API_URI}/content-project/#{cp_id}/thing/#{obj_id}/"
      options = { headers: headers }
      attributes = get(endpoint, options)
      new(attributes)
    end

    def self.create(cp_id, uid, name, pure_data)
      endpoint = "#{API_URI}/content-project/#{cp_id}/thing/"
      options = {
        headers: headers,
        body: {
          uid: uid,
          name: name,
          content_project: cp_id,
          pure_data: pure_data
        }.to_json
      }
      attributes = post(endpoint, options)
      new(attributes)
    end

    def self.update(cp_id, obj_id, uid, name, pure_data)
      endpoint = "#{API_URI}/content-project/#{cp_id}/thing/#{obj_id}/"
      options = {
        headers: headers,
        body: {
          uid: uid,
          name: name,
          content_project: cp_id,
          pure_data: pure_data
        }.to_json
      }
      attributes = put(endpoint, options)
      new(attributes)
    end

    def self.destroy(cp_id, obj_id)
      endpoint = "#{API_URI}/content-project/#{cp_id}/thing/#{obj_id}/"
      options = { headers: headers }
      delete(endpoint, options)
    end

    def self.headers
      {
        "Content-Type" => "application/json",
        "Authorization" => TOKEN
      }
    end
  end
end
