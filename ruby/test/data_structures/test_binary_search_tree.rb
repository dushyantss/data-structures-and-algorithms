# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestBinarySearchTree < Minitest::Test
    def test_everything_cause_i_am_lazy
      bst = BinarySearchTree.new

      arr = [5, 3, 7, 2, 4, 6, 8]
      bst << arr.shift while arr.any?

      bst.preorder { |n| arr << n }

      assert_equal [5, 3, 2, 4, 7, 6, 8], arr

      arr.clear
      bst.inorder { |n| arr << n }

      assert_equal [2, 3, 4, 5, 6, 7, 8], arr

      arr.clear
      bst.postorder { |n| arr << n }

      assert_equal [2, 4, 3, 6, 8, 7, 5], arr

      arr.clear
      bst.level_order { |n| arr << n }

      assert_equal [5, 3, 7, 2, 4, 6, 8], arr
    end
  end
end
