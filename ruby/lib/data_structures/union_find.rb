# frozen_string_literal: true

module DataStructures
  # A simple implementation of UnionFind
  #
  # It takes a bunch of values and creates groups of them
  class UnionFind
    # @return [Integer] the number of unions
    attr_reader :union_count

    # @param collection [#each] the collection of objects that we'll run union on
    def initialize(collection)
      @ary = []
      @obj_idx_map = {}
      @size = {}
      collection.each { |obj| ary << obj }
      ary.each_with_index { |obj, i| obj_idx_map[obj] = i }
      ary.each { |obj| size[obj] = 1 }

      @union_count = ary.size
    end

    def union(a, b)
      parent_a = find(a)
      parent_b = find(b)
      return if parent_a.equal?(parent_b)

      if size[parent_a] > size[parent_b]
        ary[obj_idx_map[parent_b]] = parent_a
        size[parent_a] += size[parent_b]
      else
        ary[obj_idx_map[parent_a]] = parent_b
        size[parent_b] += size[parent_a]
      end

      @union_count -= 1
    end

    def find(obj)
      parent = ary[obj_idx_map[obj]]
      return obj if parent.equal?(obj)

      parent = ary[obj_idx_map[parent]] until parent.equal?(ary[obj_idx_map[parent]])

      ary[obj_idx_map[obj]] = parent
    end

    def connected?(a, b)
      find(a).equal?(find(b))
    end

    private

    # @return [Array] the array containing the mapping from an object to its group's
    # root.
    attr_reader :ary

    # @return [Hash] the hash containing the mapping from an object to its own index.
    attr_reader :obj_idx_map

    # @return [Hash] the hash containing the mapping from an object to its subtree's size
    attr_reader :size
  end
end
