# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestMergeSort < Minitest::Test
    def test_everything_cause_i_am_lazy
      array = (1..10).to_a

      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], Algorithms.merge_sort(array)

      array = (1..10).to_a.shuffle

      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], Algorithms.merge_sort(array)
    end
  end
end
