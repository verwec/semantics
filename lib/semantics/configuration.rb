module Semantics
  Dotenv.load
  BASE_URI = 'https://api.ax-semantics.com/v1'.freeze
  TOKEN = ENV['TOKEN']
end
