module Semantics
  class Login < AxData

    def self.get_token(user, password)
      endpoint = '/rest-auth/login/'
      options = {
        headers: headers,
        body: {
          email: user, password: password
        }.to_json
      }

      data = post(endpoint, options)
      raise(ApiError, data) unless data.response.code == STATUS_SUCCESS
      data['key']
    end

    def self.headers
      {
        'Content-Type' => 'application/json'
      }
    end
  end
end
