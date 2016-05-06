module Semantics
  Dotenv.load
  TOKEN = ENV['TOKEN'] || raise(
    ApiMissingTokenError, 'No .env file with token present')
end
