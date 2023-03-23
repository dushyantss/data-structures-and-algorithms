# frozen_string_literal: true

module DataStructures
  # Sparse Tree is a data structure that allows us to query any range in O(1)
  # if it is overlap friendly and associative. If it is only associative then
  # we can get O(log(n)).
  # Use only by subclassing, as we have not defined any useful methods.
  class SparseTree
    # param collection [Array] The collection to build the sparse tree from
    # param overlapping [Boolean] Whether or not the tree is overlap friendly
    def initialize(collection = [], &block)
      p = largest_power_of_two(collection.size)
      @block = block
      @dp = Array.new(p + 1)
      @dp[0] = collection.dup
      1.upto(p) do |i|
        @dp[i] = Array.new(collection.size)
        prev_step_size = step_size(i - 1)
        0.upto(collection.size - step_size(i)) do |j|
          @dp[i][j] = block.call(@dp[i - 1][j], @dp[i - 1][j + prev_step_size])
        end
      end
    end

    private

    def overlapping_result(i, j)
      p = largest_power_of_two(j - i + 1)

      @block.call(@dp[p][i], @dp[p][j - step_size(p) + 1])
    end

    def associative_result(i, j)
      p = largest_power_of_two(j - i + 1)

      result = @dp[p][i]
      while i + step_size(p) <= j
        i += step_size(p)
        p = largest_power_of_two(j - i + 1)
        result = @block.call(result, @dp[p][i])
      end
      result
    end

    def largest_power_of_two(size)
      Math.log2(size).floor
    end

    def step_size(i)
      2**i
    end
  end

  # A min sparse tree is a sparse tree that can be used to compute the minimum
  # of any range in O(1) time since it is both associative and overlap friendly.
  class MinSparseTree < SparseTree
    def initialize(collection = [])
      super(collection) { |a, b| [a, b].min }
    end

    def min(i, j)
      overlapping_result(i, j)
    end
  end

  # A sum sparse tree is a sparse tree that can be used to compute the sum
  # of any range in O(log(n)) time since it is only associative.
  class SumSparseTree < SparseTree
    def initialize(collection = [])
      super(collection) { |a, b| a + b }
    end

    def sum(i, j)
      associative_result(i, j)
    end
  end
end
