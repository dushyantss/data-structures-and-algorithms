# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestIndexedPriorityQueue < Minitest::Test
    def test_everything_cause_i_am_lazy
      queue = IndexedPriorityQueue.new([10, 9, 8, 7, 6, 5, 4, 3, 2, 1])

      assert_equal 10, queue.size
      assert_equal 1, queue.peek

      queue.insert(11, 0)

      assert_equal 0, queue.peek
      assert_equal 11, queue.size
    end
  end
end
