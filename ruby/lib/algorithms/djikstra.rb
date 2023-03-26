# frozen_string_literal: true

module Algorithms
  # Djikstra algorithm
  # https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
  # It is a graph search algorithm that solves the single-source shortest path problem
  # It is a greedy algorithm
  # It is not reliable for negative weighed edges
  module Djikstra
    def djikstra_shortest_path(root)
      return if root.nil?

      result = {}
      queue = { root => 0 }

      while queue.any?
        node, weight = queue.min_by { |_node, weight| weight }
        result[node] = weight
        queue.delete(node)

        node.edges.each do |edge|
          next if result.key?(edge.to)

          queue[edge.to] = if queue.key?(edge.to)
                             [queue[edge.to], edge.weight + weight].min
                           else
                             weight + edge.weight
                           end
        end
      end

      result
    end
  end
end
