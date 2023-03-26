# frozen_string_literal: true

require "test_helper"

module Algorithms
  class TestDjikstra < Minitest::Test
    def test_everything_cause_i_am_lazy
      a = DataStructures::GraphNode.new("A")
      b = DataStructures::GraphNode.new("B")
      c = DataStructures::GraphNode.new("C")
      d = DataStructures::GraphNode.new("D")
      e = DataStructures::GraphNode.new("E")
      f = DataStructures::GraphNode.new("F")

      a.edges << DataStructures::GraphEdge.new(a, b, 50)
      a.edges << DataStructures::GraphEdge.new(a, c, 45)
      a.edges << DataStructures::GraphEdge.new(a, d, 10)

      b.edges << DataStructures::GraphEdge.new(b, c, 10)
      b.edges << DataStructures::GraphEdge.new(b, d, 15)

      c.edges << DataStructures::GraphEdge.new(c, e, 30)

      d.edges << DataStructures::GraphEdge.new(d, a, 10)
      d.edges << DataStructures::GraphEdge.new(d, e, 15)

      e.edges << DataStructures::GraphEdge.new(e, b, 20)
      e.edges << DataStructures::GraphEdge.new(e, c, 35)

      f.edges << DataStructures::GraphEdge.new(f, e, 3)

      subject = Object.new.extend Algorithms::Djikstra

      result = subject.djikstra_shortest_path(a)

      assert_equal 0, result[a]
      assert_equal 45, result[b]
      assert_equal 45, result[c]
      assert_equal 10, result[d]
      assert_equal 25, result[e]
      assert_nil result[f]
    end
  end
end
