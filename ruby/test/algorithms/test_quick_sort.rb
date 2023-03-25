# frozen_string_literal: true

require "test_helper"

module Algorithms
  class TestQuickSort < Minitest::Test
    def test_sorted_array
      subject = Object.new.extend Algorithms::QuickSort
      array = (1..10).to_a

      subject.quick_sort(array)

      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], array
    end

    def test_unsorted_array
      subject = Object.new.extend Algorithms::QuickSort
      array = [10, 8, 4, 3, 2, 1, 7, 9, 6, 5]
      subject.quick_sort(array)

      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], array
    end
  end
end
