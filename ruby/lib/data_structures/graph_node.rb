# frozen_string_literal: true

module DataStructures
  # GraphNode
  # It is a node in a graph
  class GraphNode
    attr_accessor :value, :edges

    def initialize(value)
      @value = value
      @edges = []
    end
  end

  # GraphEdge
  # It is an edge in a graph
  class GraphEdge
    attr_accessor :from, :to, :weight

    def initialize(from, to, weight)
      @from = from
      @to = to
      @weight = weight
    end
  end
end
