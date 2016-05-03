module Semantics
  class Login
    include HTTParty

    base_uri BASE_URI

    def self.get_token(user, password)
      endpoint = "/rest-auth/login/"
      options = {
        headers: headers,
        body: {
          email: user,
          password: password,
        }.to_json
      }

      data = post(endpoint, options)
      raise ApiError.new(data) unless data.response.code == '200'
      data['key']
    end

    def self.headers
      {
        'Content-Type' => 'application/json'
      }
    end
  end
end
