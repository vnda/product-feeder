require "httparty"
require "json"
require "singleton"
require "./config/credentials"

class API

  class API::UnknownError < StandardError; end

  def self.get host, path, credentials
    base = create_base(host)
    response = HTTParty.get("#{base}#{path}", basic_auth: credentials)
    if response.code == 200
      return JSON(response.body)
    else
      raise API::UnknownError.new("#{response.code} - #{response.body}")
    end
  end

  def self.create_base host
   "http://#{host}/api"
  end
end
