# frozen_string_literal: true

module DataStructures
  # An implementation of Doubly linked list
  class DoublyLinkedList
    # @return [Integer]
    attr_reader :size

    def initialize
      self.size = 0
      self.head = self.tail = nil
    end

    def clear
      until tail.nil?
        prev = tail.prev
        prev.nxt = nil
        tail.prev = nil
        self.tail = prev
      end

      self.head = nil
      self.size = 0
    end

    def empty?
      size.zero?
    end

    def <<(value)
      append_last(value)
    end

    def append_first(value)
      node = Node.new(value: value, nxt: head)
      self.size += 1

      (self.head = self.tail = node) && return if size == 1

      head.prev = node
      self.head = node

      self.size += 1
    end

    def append_last(value)
      node = Node.new(value: value, prev: tail)
      self.size += 1

      (self.head = self.tail = node) && return if size == 1

      tail.nxt = node
      self.tail = node
    end

    def peek_first
      head&.value
    end

    def peek_last
      tail&.value
    end

    # @return the value of the Node
    def remove_first
      return if empty?

      self.size -= 1
      result = head.value

      self.head = head.nxt
      if empty?
        self.tail = nil
      else
        head.prev.nxt = nil
        head.prev = nil
      end

      result
    end

    # @return the value of the Node
    def remove_last
      return if empty?

      self.size -= 1
      result = tail.value

      self.tail = tail.prev
      if empty?
        self.head = nil
      else
        tail.nxt.prev = nil
        tail.nxt = nil
      end

      result
    end

    # @param index [Integer]
    # @return the value of the Node
    def remove_at(index)
      raise ArgumentError, "index: #{index} out of range" if index.negative? || index >= size

      return remove_first if index.zero?
      return remove_last if (index + 1) == size

      node = nil
      if index <= (size / 2)
        node = head
        index.times { node = node.nxt }
      else
        node = tail
        (size - index - 1).times { node = node.prev }
      end

      remove_node(node)
    end

    # @param value [Object] the value to find
    def remove(value)
      i = index_of(value)
      return unless i

      remove_at(i)
    end

    # @param value [Object] the value to find
    def index_of(value)
      i = 0
      node = head
      while node && node.value != value
        i += 1
        node = node.nxt
      end

      return i if node
    end

    def contains(value)
      !index_of(value).nil?
    end

    def each
      if block_given?
        node = head
        until node.nil?
          yield node.value
          node = node.nxt
        end
      else
        to_enum(:each)
      end
    end

    def reverse_each
      if block_given?
        node = tail
        until node.nil?
          yield node.value
          node = node.prev
        end
      else
        to_enum(:reverse_each)
      end
    end

    private

    # @return [Integer]
    attr_writer :size
    # @return [Node]
    attr_accessor :head, :tail

    # @param node [Node]
    # @return the value of the Node
    def remove_node(node)
      return remove_first if node.prev.nil?
      return remove_last if node.nxt.nil?

      node.prev.nxt = node.nxt
      node.nxt.prev = node.prev

      result = node.value

      node.nxt = node.prev = nil
      self.size -= 1
      result
    end

    # A node within the linked list
    class Node
      attr_accessor :value, :prev, :nxt # next is a keyword in ruby

      # @param value [Object]
      # @param prev [Node, NilClass]
      # @param nxt [Node, NilClass]
      def initialize(value:, prev: nil, nxt: nil)
        self.value = value
        self.prev = prev
        self.nxt = nxt
      end
    end
  end
end
