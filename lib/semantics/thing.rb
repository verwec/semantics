module Semantics
  class Thing
    include HTTParty

    base_uri BASE_URI

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def self.find(cp_id, obj_id)
      endpoint = "/content-project/#{cp_id}/thing/#{obj_id}/"
      options = { headers: headers }
      attributes = get(endpoint, options)
      raise ApiError.new(attributes) unless attributes.response.code == '200'
      new(attributes)
    end

    def self.create(cp_id, uid, name, pure_data)
      endpoint = "/content-project/#{cp_id}/thing/"
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
      raise ApiError.new(attributes) unless attributes.response.code == '201'
      new(attributes)
    end

    def self.update(cp_id, obj_id, uid, name, pure_data)
      endpoint = "/content-project/#{cp_id}/thing/#{obj_id}/"
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
      raise ApiError.new(attributes) unless attributes.response.code == '200'
      new(attributes)
    end

    def self.destroy(cp_id, obj_id)
      endpoint = "/content-project/#{cp_id}/thing/#{obj_id}/"
      options = { headers: headers }
      raise ApiError.new(attributes) unless attributes.response.code == '200'
      delete(endpoint, options)
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
