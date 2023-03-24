# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestBinarySearch < Minitest::Test
    def test_everything_cause_i_am_lazy
      array = (1..10).to_a

      assert_equal 2, Algorithms.binary_search(array, 3)
      assert_equal 5, Algorithms.binary_search(array, 6)
      assert_equal 0, Algorithms.binary_search(array, 1)
      assert_nil Algorithms.binary_search(array, 0)
      assert_nil Algorithms.binary_search(array, 11)
    end
  end
end
