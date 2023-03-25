# frozen_string_literal: true

module Algorithms
  # Binary search algorithm
  module BinarySearch
    # Binary search algorithm
    # Array must be sorted
    # Time complexity: O(log n)
    # Space complexity: O(1)
    # @param array [Array] array of integers
    # @param value [Integer] value to search
    # @param low [Integer] low index
    # @param high [Integer] high index
    # @return [Integer] index of the value
    # @example
    #  Algorithms.binary_search([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 3) => 2
    #  Algorithms.binary_search([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 6) => 5
    #  Algorithms.binary_search([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 1) => 0
    #  Algorithms.binary_search([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 0) => nil
    #  Algorithms.binary_search([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 11) => nil
    def binary_search(array, value, low = 0, high = array.length - 1)
      return nil if low > high

      mid = (low + high) / 2
      return mid if array[mid] == value

      if value < array[mid]
        binary_search(array, value, low, mid - 1)
      else
        binary_search(array, value, mid + 1, high)
      end
    end
  end
end
