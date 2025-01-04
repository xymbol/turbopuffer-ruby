# frozen_string_literal: true

module Turbopuffer
  class Namespace
    def initialize(name, connection)
      @name = name
      @connection = connection
    end

    def delete(ids:)
      payload = {
        ids: ids,
        vectors: [nil] * ids.length
      }
      response = @connection.delete("/v1/namespaces/#{@name}", payload)
      handle_response(response)
    end

    def delete_all
      response = @connection.delete("/v1/namespaces/#{@name}")
      handle_response(response)
    end

    def query(vector:, top_k: 10, distance_metric: "cosine_distance", filters: nil, include_attributes: false, include_vectors: false)
      payload = {
        vector: vector,
        top_k: top_k,
        distance_metric: distance_metric,
        filters: filters,
        include_attributes: include_attributes,
        include_vectors: include_vectors
      }
      response = @connection.post("/v1/namespaces/#{@name}/query", payload)
      handle_response(response)
    end

    def upsert(ids:, vectors:, attributes: nil, distance_metric: "cosine_distance")
      payload = {
        ids: ids,
        vectors: vectors,
        attributes: attributes,
        distance_metric: distance_metric
      }
      response = @connection.post("/v1/namespaces/#{@name}", payload)
      handle_response(response)
    end

    private

    def handle_response(response)
      if response.success?
        response.body
      else
        raise Error, "API Error: #{response.status} - #{response.body}"
      end
    end
  end
end
