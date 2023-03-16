# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestAVLTree < Minitest::Test
    def test_everything_cause_i_am_lazy
      tree = AVLTree.new
      (1..10).each { |i| tree.insert(i) }

      assert_equal 10, tree.node_count
      assert_equal 10, tree.each_node.count
      assert_equal 3, tree.root.height
      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], tree.to_a
      tree.each_node.all? { |node| assert_includes [-1, 0, 1], node.balance_factor }

      tree.remove(5)

      assert_equal 9, tree.node_count
      assert_equal 9, tree.each_node.count
      assert_equal 3, tree.root.height
      tree.each_node.all? { |node| assert_includes [-1, 0, 1], node.balance_factor }
    end
  end
end
