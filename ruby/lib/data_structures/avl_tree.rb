# frozen_string_literal: true

module DataStructures
  # AVL tree implementation.
  # * AVL tree is a self-balancing binary search tree.
  # * It is a height-balanced binary tree.
  # * It is a binary search tree in which the difference between the heights of
  #   the left and right subtrees cannot be more than one.
  class AVLTree
    include Enumerable

    attr_reader :root, :node_count

    def initialize
      @root = nil
      @node_count = 0
    end

    def each
      return to_enum(:each) unless block_given?

      inorder_traversal(@root) { |node| yield node.value }
    end

    def each_node(&)
      return to_enum(:each_node) unless block_given?

      inorder_traversal(@root, &)
    end

    def insert(value)
      return false if value.nil? || contains?(@root, value)

      @root = do_insert(@root, value)
      @node_count += 1

      true
    end

    def remove(value)
      return false unless contains?(@root, value)

      do_remove(@root, value)
      @node_count -= 1
    end

    private

    def inorder_traversal(node, &)
      return if node.nil?

      inorder_traversal(node.left, &)
      yield node
      inorder_traversal(node.right, &)
    end

    def contains?(node, value)
      return false if node.nil?

      value == node.value || contains?(value < node.value ? node.left : node.right, value)
    end

    def do_insert(node, value)
      return Node.new(value) if node.nil?

      if value < node.value
        node.left = do_insert(node.left, value)
      else
        node.right = do_insert(node.right, value)
      end

      update(node)
      balance(node)
    end

    def do_remove(node, value)
      return nil if node.nil?

      if value < node.value
        node.left = do_remove(node.left, value)
      elsif value > node.value
        node.right = do_remove(node.right, value)
      else
        # First of these two will also handle the case where both are nil.
        return node.left if node.right.nil?
        return node.right if node.left.nil?

        if node.left.height > node.right.height
          successor = node.left
          successor = successor.right while successor.right

          node.value = successor.value
          node.left = do_remove(node.left, successor.value)
        else
          successor = node.right
          successor = successor.left while successor.left

          node.value = successor.value
          node.right = do_remove(node.right, successor.value)
        end
      end

      update(node)
      balance(node)
    end

    def update(node)
      left_height = node.left.nil? ? -1 : node.left.height
      right_height = node.right.nil? ? -1 : node.right.height

      node.height = [left_height, right_height].max + 1

      node.balance_factor = right_height - left_height
    end

    def balance(node)
      case node.balance_factor
      when -2
        node.left.balance_factor <= 0 ? left_left_case(node) : left_right_case(node)
      when 2
        node.right.balance_factor >= 0 ? right_right_case(node) : right_left_case(node)
      else
        # -1, 0, 1. No other case possible since we'll balance from the bottom
        # in `update` method.
        node
      end
    end

    def left_left_case(node)
      rotate_right(node)
    end

    def left_right_case(node)
      node.left = rotate_left(node.left)
      left_left_case(node)
    end

    def right_right_case(node)
      rotate_left(node)
    end

    def right_left_case(node)
      node.right = rotate_right(node.right)
      right_right_case(node)
    end

    def rotate_right(node)
      return node if node.nil?

      left = node.left

      node.left = left.right
      left.right = node

      update(node)
      update(left)

      left
    end

    def rotate_left(node)
      return node if node.nil?

      right = node.right

      node.right = right.left
      right.left = node

      update(node)
      update(right)

      right
    end

    # Node of the AVL tree
    class Node
      attr_accessor :left, :right, :value, :height, :balance_factor

      def initialize(value)
        @value = value
        @height = 0
        @balance_factor = 0
      end
    end
  end
end
