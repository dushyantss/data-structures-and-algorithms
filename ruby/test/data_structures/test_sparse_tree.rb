# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestSparseTree < Minitest::Test
    def test_min_sparse_tree
      tree = MinSparseTree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

      assert_equal 1, tree.min(0, 0)
      assert_equal 2, tree.min(1, 1)
      assert_equal 1, tree.min(0, 1)
      assert_equal 3, tree.min(2, 2)
      assert_equal 2, tree.min(1, 2)
      assert_equal 1, tree.min(0, 2)
    end

    def test_sum_sparse_tree
      tree = SumSparseTree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

      assert_equal 1, tree.sum(0, 0)
      assert_equal 2, tree.sum(1, 1)
      assert_equal 3, tree.sum(0, 1)
      assert_equal 3, tree.sum(2, 2)
      assert_equal 5, tree.sum(1, 2)
      assert_equal 6, tree.sum(0, 2)
      assert_equal 55, tree.sum(0, 9)
    end
  end
end
