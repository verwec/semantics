module Semantics
  class Thing < AxData

    def self.all(cp_id = nil)
      endpoint = "/allthings/?page_size=100000&content_project_pk=#{cp_id}"
      options = { headers: headers }
      data = get(endpoint, options)
      raise(ApiError, data) unless data.response.code == STATUS_SUCCESS
      data['results'].map { |d| Thing.new(d) }
    end

    def self.find(cp_id, obj_id)
      endpoint = "/content-project/#{cp_id}/thing/#{obj_id}/"
      options = { headers: headers }
      data = get(endpoint, options)
      raise(ApiError, data) unless data.response.code == STATUS_SUCCESS
      new(data)
    end

    def self.create(cp_id, uid, name, pure_data)
      endpoint = "/content-project/#{cp_id}/thing/"
      options = {
        headers: headers,
        body: {
          uid: uid, name: name, content_project: cp_id, pure_data: pure_data
        }.to_json
      }
      data = post(endpoint, options)
      raise(ApiError, data) unless data.response.code == STATUS_CREATED
      new(data)
    end

    def self.update(cp_id, obj_id, uid, name, pure_data)
      endpoint = "/content-project/#{cp_id}/thing/#{obj_id}/"
      options = {
        headers: headers,
        body: {
          uid: uid, name: name, content_project: cp_id, pure_data: pure_data
        }.to_json
      }
      data = put(endpoint, options)
      raise(ApiError, data) unless data.response.code == STATUS_SUCCESS
      new(data)
    end

    def self.generate_content(cp_id, obj_id)
      endpoint = "/content-project/#{cp_id}/thing/"\
        "#{obj_id}/generate_content/?force=true"
      options = { headers: headers }
      data = post(endpoint, options)
      raise(ApiError, data) unless data.response.code == STATUS_ACCEPTED
      data['status']
    end

    def self.destroy(cp_id, obj_id)
      endpoint = "/content-project/#{cp_id}/thing/#{obj_id}/"
      options = { headers: headers }
      data = delete(endpoint, options)
      raise(ApiError, data) unless data.response.code == STATUS_DELETED
      true
    end

    def update(uid, name, pure_data)
      self.class.update(content_project, id, uid, name, pure_data)
    end

    def destroy
      self.class.destroy(content_project, id)
    end
  end
end
