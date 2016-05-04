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
      data = get(endpoint, options)
      raise ApiError.new(data) unless data.response.code == '200'
      new(data)
    end

    def self.all(cp_id=nil)
      endpoint = "/allthings/?page_size=1000&content_project_pk=#{cp_id}"
      options = { headers: headers }
      data = get(endpoint, options)
      raise ApiError.new(data) unless data.response.code == '200'
      data['results'].map { |d| Thing.new(d) }
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
      data = post(endpoint, options)
      raise ApiError.new(data) unless data.response.code == '201'
      new(data)
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
      data = put(endpoint, options)
      raise ApiError.new(data) unless data.response.code == '200'
      new(data)
    end

    def self.generate_content(cp_id, obj_id)
      endpoint = "/content-project/#{cp_id}/thing/#{obj_id}/generate_content/?force=true"
      options = { headers: headers }

      data = post(endpoint, options)
      raise ApiError.new(data) unless data.response.code == '200'
      data['status']
    end

    def self.destroy(cp_id, obj_id)
      endpoint = "/content-project/#{cp_id}/thing/#{obj_id}/"
      options = { headers: headers }
      data = delete(endpoint, options)
      raise ApiError.new(data) unless data.response.code == '204'
      true
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
