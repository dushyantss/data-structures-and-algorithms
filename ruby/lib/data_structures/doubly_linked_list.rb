# frozen_string_literal: true

module DataStructures
  # An implementation of Doubly linked list
  class DoublyLinkedList
    include Enumerable

    alias to_ary to_a

    # @return [Integer]
    attr_reader :size

    # @param ary [Array] a collection which will be moved into this
    def initialize(ary = nil)
      self.size = 0
      # @type [Node]
      self.head = self.tail = nil

      concat(ary) if ary
    end

    # Runs the provided block on every value of the list.
    # If no block is provided returns an enumerator.
    # The heart and soul of the included Enumerable module.
    # @yieldparam value [Object] each value in the list
    # @return [Enumerator]
    def each
      return to_enum(:each) unless block_given?

      node = head
      until node.nil?
        yield node.value
        node = node.next
      end
    end

    # Runs the provided block on every value of the list in reverse order.
    # If no block is provided returns an enumerator.
    # Used by some methods in Enumerable which run in the reverse order.
    # @yieldparam value [Object] each value in the list
    # @return [Enumerator]
    def reverse_each
      return to_enum(:reverse_each) unless block_given?

      node = tail
      until node.nil?
        yield node.value
        node = node.prev
      end
    end

    # Inspect the list
    # Returns a string representing the list
    # It should look like "[val1, val2, val3]"
    # @return [String]
    def inspect
      to_string(val_method: :inspect)
    end

    # Convert the list to a string
    # Returns a string representing the list
    # It should look like "[val1, val2, val3]"
    # @return [String]
    def to_s
      to_string
    end

    # The most common way to compare
    # @param other [DataStructures::DoublyLinkedList] the other list
    # @return [Boolean, NilClass]
    def ==(other)
      return false if other.nil? || !other.is_a?(self.class) || other.size != size

      zip(other).all? { |v, other_v| v == other_v }
    end

    # Get the value at the index
    # @param index [Integer]
    # @return [Object, NilClass]
    def [](index)
      node_at(index)&.value
    end

    alias at []

    # Set the value at the index
    # @param index [Integer]
    # @param value [Object]
    # @return [Object, NilClass]
    def []=(index, value)
      node_at(index)&.value = value
    end

    # Returns the first n values
    # If count == nil, then returns the first value
    # Else, returns the first n values wrapped in an array
    # @param count [Integer, NilClass]
    # @return [Object, Array, NilClass]
    def first(count = nil)
      return head&.value if count.nil?

      take(count)
    end

    # Returns the last n values
    # If count == nil, then returns the last value
    # Else, returns the last n values wrapped in an array
    # @param count [Integer, NilClass]
    # @return [Object, Array, NilClass]
    def last(count = nil)
      return tail&.value if count.nil?

      drop(size - count)
    end

    # Concats the other collection within the current list and returns self
    # @param other [#each]
    # @return [DataStructures::DoublyLinkedList]
    def concat(other)
      unless other.respond_to? :each
        raise ArgumentError,
              "#{other} cannot be concatenated. Please provide a collection with an each method"
      end

      other.each { |val| self << val }

      self
    end

    # Clear the list
    def clear
      # GC would reclaim all the other nodes
      self.head = self.tail = nil
      self.size = 0
      self
    end

    # Whether the list is empty?
    # @return [Boolean]
    def empty?
      size.zero?
    end

    # Append the value to the list at the end
    # @param value [Object]
    def <<(value)
      append_last(value)
    end

    # Append the value to the list at the end
    # @param value [Object]
    def push(value)
      append_last(value)
    end

    # Append the value to the list at the start
    # @param value [Object]
    def unshift(value)
      append_first(value)
    end

    # Remove the value to the list from the start
    # @return [Object, NilClass] the value, or nil if empty list
    def shift
      remove_node(head)
    end

    # Remove the value to the list from the end
    # @return [Object, NilClass] the value, or nil if empty list
    def pop
      remove_node(tail)
    end

    # Remove the value at the index and return it
    # @param index [Integer]
    # @return [Object, NilClass]
    def remove_at(index)
      remove_node(node_at(index))
    end

    # Remove the value if found in the list
    # @param value [Object] the value to find
    # @return [Object, NilClass]
    def remove(value)
      remove_node(find_node(value))
    end

    private

    attr_writer :size
    attr_accessor :head, :tail

    Node = Struct.new(:value, :prev, :next, keyword_init: true)

    def append_first(value)
      node = Node.new(value: value, next: head)
      self.size += 1

      (self.head = self.tail = node) && return if size == 1

      head.prev = node
      self.head = node

      self.size += 1

      self
    end

    def append_last(value)
      node = Node.new(value: value, prev: tail)
      self.size += 1

      (self.head = self.tail = node) && return if size == 1

      tail.next = node
      self.tail = node

      value
    end

    def each_node
      return to_enum(:each_node) unless block_given?

      node = head
      until node.nil?
        yield node
        node = node.next
      end
    end

    def find_node(value)
      each_node.find { |node| node.value == value }
    end

    def to_string(val_method: :to_s)
      s = String.new "["
      each_with_index do |val, i|
        s << if val.equal?(self)
               "[...]"
             else
               val.public_send(val_method)
             end
        s << ", " unless i == size - 1
      end
      s << "]"
      s
    end

    def node_at(index)
      index += size if index.negative?

      return head if index.zero?

      return nil if index >= size || index.negative?
      return tail if index == (size - 1)

      node = nil
      if index <= (size / 2)
        node = head
        index.times { node = node.next }
      else
        node = tail
        (size - index - 1).times { node = node.prev }
      end

      node
    end

    # @param node [Node]
    # @return the value of the Node
    def remove_node(node)
      return if node.nil?

      node.prev.next = node.next unless node.prev.nil?
      node.next.prev = node.prev unless node.next.nil?

      self.head = node.next if node.prev.nil?
      self.tail = node.prev if node.next.nil?

      self.size -= 1
      node.value
    end
  end
end

# No longer using the c extension since its performance is worse than array
# for push, pop, shift and unshift. If it can't be faster even for shift and unshift
# then the only use case for it is to use when we can't afford to double the array
# size due to memory constraints and I am not sure I'd still like to use a
# linked list there due to performance reasons.

# DataStructures::DoublyLinkedList = begin
#   require "data_structures/c_doubly_linked_list"
#   DataStructures::CDoublyLinkedList
# rescue LoadError # C Version could not be found, try ruby version
#   pp "Could not load c extensions for DoublyLinkedList"
#   DataStructures::RubyDoublyLinkedList
# end
