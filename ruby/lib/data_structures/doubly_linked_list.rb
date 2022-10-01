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
      append_end(value)
    end

    def append_start(value)
      node = Node.new(value: value, nxt: head)
      self.size += 1

      (self.head = self.tail = node) && return if size == 1

      head.prev = node
      self.head = node

      self.size += 1
    end

    def append_end(value)
      node = Node.new(value: value, prev: tail)
      self.size += 1

      (self.head = self.tail = node) && return if size == 1

      tail.nxt = node
      self.tail = node
    end

    def peek_start
      head&.value
    end

    def peek_end
      tail&.value
    end

    def remove_start
      return if empty?

      self.size -= 1

      result = head.value

      old_head = head
      self.head = head.nxt
      if head.nil?
        self.tail = nil
      else
        old_head.nxt = head.prev = nil
      end

      result
    end

    private

    # @return [Integer]
    attr_writer :size
    # @return [Node]
    attr_accessor :head, :tail

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
