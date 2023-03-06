# frozen_string_literal: true

module DataStructures
  # A simple binary search tree
  class BinarySearchTree
    def initialize
      @root = nil
    end

    def <<(value)
      new_node = Node.new(value, left: nil, right: nil)

      unless @root
        @root = new_node
        return
      end

      prev = nil
      node = @root
      while node
        prev = node
        node = value < node.value ? node.left : node.right
      end

      if value < prev.value
        prev.left = new_node
      else
        prev.right = new_node
      end
    end

    def preorder(&)
      @root&.preorder(&)
    end

    def inorder(&)
      @root&.inorder(&)
    end

    def postorder(&)
      @root&.postorder(&)
    end

    def level_order(&)
      return unless @root

      queue = [@root]

      while queue.any?
        node = queue.shift
        yield node.value if block_given?
        queue << node.left if node.left
        queue << node.right if node.right
      end
    end

    # Simple node class for the BinarySearchTree, doesn't refer its parent node
    class Node
      attr_accessor :value, :left, :right

      def initialize(value, left:, right:)
        @value = value
        @left = left
        @right = right
      end

      def preorder(&)
        yield value if block_given?
        left&.preorder(&)
        right&.preorder(&)
      end

      def inorder(&)
        left&.inorder(&)
        yield value if block_given?
        right&.inorder(&)
      end

      def postorder(&)
        left&.postorder(&)
        right&.postorder(&)
        yield value if block_given?
      end
    end
  end
end
