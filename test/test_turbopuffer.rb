# frozen_string_literal: true

require "test_helper"
require "securerandom"

class TestTurbopuffer < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Turbopuffer::VERSION
  end

  def test_usage_example
    tpuf = Turbopuffer::Client.new

    ns = tpuf.namespace("test-#{SecureRandom.uuid}")

    ns.upsert(
      ids: [1, 2],
      vectors: [[0.1, 0.2], [0.3, 0.4]],
      attributes: {name: ["foo", "bar"]}
    )

    results = ns.query(
      vector: [0.15, 0.22],
      top_k: 10
    )

    assert_equal 2, results.length
    assert_equal 2, results[0][:id]
    assert_in_delta 0.001, results[0][:dist], 0.001

    ns.delete_all
  end
end
