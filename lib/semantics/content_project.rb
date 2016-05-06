module Semantics
  class ContentProject < AxData
    def self.all
      endpoint = '/content-project/'
      options = { headers: headers }
      data = get(endpoint, options)
      raise(ApiError, data) unless data.response.code == STATUS_SUCCESS
      data['results'].map { |d| ContentProject.new(d) }
    end

    def self.find(cp_id)
      endpoint = "/content-project/#{cp_id}/"
      options = { headers: headers }
      data = get(endpoint, options)
      raise(ApiError, data) unless data.response.code == STATUS_SUCCESS
      new(data)
    end

    def self.create(name, engine_configuration)
      endpoint = '/content-project/'
      options = {
        headers: headers,
        body: {
          name: name, engine_configuration: engine_configuration
        }.to_json
      }
      data = post(endpoint, options)
      raise(ApiError, data) unless data.response.code == STATUS_CREATED
      new(data)
    end
  end
end
