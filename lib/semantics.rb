require 'httparty'
require './lib/semantics/content_project'

module Semantics
  TOKEN = ENV['TOKEN'] || raise('No Token')
  API_URI = 'https://api.ax-semantics.com/v1'
end
