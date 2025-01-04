# frozen_string_literal: true

require "faraday"

module Turbopuffer
  class Client
    BASE_URL = "https://api.turbopuffer.com"

    def initialize(api_token)
      @api_token = api_token
      @connection = Faraday.new(url: BASE_URL) do |conn|
        conn.request :json
        conn.response :json, parser_options: {symbolize_names: true}
        conn.headers["Authorization"] = "Bearer #{@api_token}"
        conn.headers["Accept-Encoding"] = "gzip"
        conn.adapter Faraday.default_adapter
      end
    end

    def namespace(name)
      Namespace.new(name, @connection)
    end
  end
end
