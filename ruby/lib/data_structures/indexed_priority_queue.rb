# frozen_string_literal: true

require "forwardable"

module DataStructures
  # IndexedPriorityQueue is a priority queue that allows you to change the
  # priority of an item in the queue.
  # We'll be making a min priority queue, so lower the number, the higher the
  # priority.
  class IndexedPriorityQueue
    extend Forwardable

    attr_reader :size

    # param [#to_a] collection an enumerable collection of items
    def initialize(collection = nil)
      @values = collection.to_a
      @ki_to_heap = Array.new(@values.size) { |i| i }
      @heap_to_ki = @ki_to_heap.dup

      @size = @values.size

      build_heap
    end

    def delete(ki)
      i = @ki_to_heap[ki]
      swap(i, @size - 1)

      @ki_to_heap[ki] = -1
      @heap_to_ki[@size - 1] = -1
      @size -= 1

      sink(i)
      swim(i)

      @values[ki] = nil
    end

    def value_of(ki)
      @values[ki]
    end

    def contains(ki)
      @ki_to_heap[ki].positive?
    end

    def peek_ki
      @heap_to_ki[0]
    end

    def poll_ki
      ki = peek_ki
      delete(ki)

      ki
    end

    def peek
      @values[peek_ki]
    end

    def poll
      delete(peek_ki)
    end

    def insert(ki, value)
      @values[ki] = value

      @ki_to_heap[ki] = @size
      @heap_to_ki[@size] = ki

      swim(@size)
      @size += 1

      value
    end

    def update(ki, value)
      prev = @values[ki]
      @values[ki] = value
      if value < prev
        swim(@ki_to_heap[ki])
      else
        sink(@ki_to_heap[ki])
      end
    end

    def increase(ki, value)
      update(ki, @values[ki] + value)
    end

    def decrease(ki, value)
      update(ki, @values[ki] - value)
    end

    private

    def build_heap
      (@size / 2).downto(0) do |i|
        sink(i)
      end
    end

    def swim(i)
      while i.positive? && less(i, parent(i))
        swap(i, parent(i))
        i = parent(i)
      end
    end

    def sink(i)
      while left(i) < @size
        min_child = left(i)
        min_child = right(i) if right(i) < @size && less(right(i), left(i))

        break unless less(min_child, i)

        swap(i, min_child)
        i = min_child
      end
    end

    def swap(i, j)
      @ki_to_heap[@heap_to_ki[i]] = j
      @ki_to_heap[@heap_to_ki[j]] = i

      @heap_to_ki[i], @heap_to_ki[j] = @heap_to_ki[j], @heap_to_ki[i]
    end

    def less(i, j)
      @values[@heap_to_ki[i]] < @values[@heap_to_ki[j]]
    end

    def parent(i)
      (i - 1) / 2
    end

    def left(i)
      (2 * i) + 1
    end

    def right(i)
      (2 * i) + 2
    end
  end
end
