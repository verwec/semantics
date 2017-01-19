module Semantics
  class AxData
    include HTTParty
    base_uri 'https://api.ax-semantics.com/v1'.freeze

    STATUS_SUCCESS  = '200'
    STATUS_CREATED  = '201'
    STATUS_ACCEPTED = '202'
    STATUS_DELETED  = '204'

    attr_reader :data

    def self.headers
      {
        'Content-Type' => 'application/json',
        'Authorization' => Semantics.configuration.api_token
      }
    end

    def initialize(data)
      @data = data
    end

    def method_missing(method)
      data[method.to_s]
    end
  end
end
