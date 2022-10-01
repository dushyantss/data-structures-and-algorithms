# frozen_string_literal: true

class DynamicArray
  include Enumerable

  DEFAULT_CAPACITY = 8

  # @param cap [Integer]
  def initialize(cap = DEFAULT_CAPACITY)
    self.capacity = [cap, 0].max
    self.len = 0
    self.arr = Array.new(capacity)
  end

  # @return [Integer]
  def size
    len
  end

  # @return [Boolean]
  def empty?
    len.zero?
  end

  def [](index)
    arr[index]
  end

  def []=(index, value)
    if index >= capacity
      self.capacity = index + 1
      move_to_new_arr
      self.len = index
    end

    arr[index] = value
  end

  def <<(value)
    if len == capacity
      self.capacity *= 2
      move_to_new_arr
    end

    self[len] = value
    self.len += 1
  end

  def pop
    return if len.zero?

    val = self[len - 1]
    self.len -= 1
    val
  end

  # concat the provided array to this array
  # @param other [Array]
  def concat(other)
    other.each { |v| self << v }
  end

  def each(&block)
    arr.each(&block)
  end

  private

  # @return [Integer]
  attr_accessor :len
  # @return [Integer]
  attr_accessor :capacity
  # @return [Array]
  attr_accessor :arr

  def move_to_new_arr
    arr = Array.new(capacity)

    self.arr.each_with_index { |item, i| arr[i] = item }
    self.arr = arr
  end
end
