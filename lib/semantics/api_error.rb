module Semantics
  class ApiError < StandardError
    def initialize(msg)
      super(msg.parsed_response["detail"])
    end
  end
end
