# frozen_string_literal: true

require "faraday"

module Turbopuffer
  class Client
    DEFAULT_BASE_URL = "https://api.turbopuffer.com"

    attr_reader :api_key, :base_url

    def initialize(api_key = default_api_key, base_url = default_base_url)
      @api_key = api_key
      @base_url = base_url
    end

    def namespace(name)
      Namespace.new(name, conn)
    end

    private

    def conn
      @conn ||= Faraday.new(url: base_url) do |conn|
        conn.request :json
        conn.response :json, parser_options: {symbolize_names: true}
        conn.headers["Authorization"] = "Bearer #{api_key}"
        conn.headers["Accept-Encoding"] = "gzip"
        conn.adapter Faraday.default_adapter
      end
    end

    def default_api_key
      ENV["TURBOPUFFER_API_KEY"]
    end

    def default_base_url
      ENV["TURBOPUFFER_API_BASE_URL"] || DEFAULT_BASE_URL
    end
  end
end
