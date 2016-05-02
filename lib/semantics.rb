require 'dotenv'
require 'httparty'

Dir[File.dirname(__FILE__) + '/semantics/*.rb'].each { |f| require f }

module Semantics
end
