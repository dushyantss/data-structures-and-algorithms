# frozen_string_literal: true

require "forwardable"

module DataStructures
  # A Simple Heap class
  class Heap
    extend Forwardable

    def_delegators :@ary, :length, :empty?
    def_delegator :@ary, :first, :peek
    # @param collection [#each] the collection to heapify
    def initialize(collection = nil)
      self.ary = []

      concat(collection) unless collection.nil?
    end

    def <<(val)
      ary << val
      i = length - 1

      return val if i.zero?

      loop do
        p = parent(i)
        # This turns into if i <= 0 || ary[p] <= val for a min heap
        # So, we break if either we're out of bounds or the parent
        # is already smaller than us.
        break if i <= 0 || ary[p].public_send(comparator, val)

        ary[p], ary[i] = ary[i], ary[p]
        i = p
      end

      val
    end

    def pop
      return ary.pop if length <= 1

      ary[0], ary[-1] = ary[-1], ary[0]
      val = ary.pop
      i = 0
      while i < length
        l = left(i)
        r = right(i)
        if l < length && ary[l].public_send(comparator, ary[i])
          if r < length && ary[r].public_send(comparator, ary[l])
            ary[i], ary[r] = ary[r], ary[i]
            i = r
          else
            ary[i], ary[l] = ary[l], ary[i]
            i = l
          end
        elsif r < length && ary[r].public_send(comparator, ary[l])
          ary[i], ary[r] = ary[r], ary[i]
          i = r
        else
          break
        end
      end

      val
    end

    # @param collection [#each] the collection to heapify
    def concat(collection)
      collection.each { |val| self << val }
    end

    private

    # @return [Array]
    attr_accessor :ary

    def comparator
      raise NotImplementedError("Should be :<= for MinHeap and :>= for MaxHeap")
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

  # A min heap
  class MinHeap < Heap
    def comparator
      :<=
    end
  end

  # A max heap
  class MaxHeap < Heap
    def comparator
      :>=
    end
  end
end
