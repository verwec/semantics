require 'httparty'

require_relative 'semantics/api_error'
require_relative 'semantics/api_misssing_token_error'
require_relative 'semantics/ax_data'
require_relative 'semantics/content_project'
require_relative 'semantics/login'
require_relative 'semantics/thing'

module Semantics
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_token
  end
end
