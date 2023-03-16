# frozen_string_literal: true

module DataStructures
  # FenwickTree is a data structure that can efficiently update elements and
  # calculate prefix sums in a table of numbers.
  # i in the methods is 1 based, not 0 based like arrays
  class FenwickTree
    def initialize(arr)
      @tree = Array.new(arr.size + 1, 0)

      arr.each_with_index do |val, i|
        @tree[i + 1] = val
      end

      (1...@tree.size).each do |i|
        j = i + lsb(i)
        @tree[j] += @tree[i] if j < @tree.size
      end
    end

    # The method is 1 based, not 0 based like arrays
    def prefix_sum(i)
      sum = 0
      while i.positive?
        sum += @tree[i]
        i -= lsb(i)
      end
      sum
    end

    # The method is 1 based, not 0 based like arrays
    def range_sum(i, j)
      prefix_sum(j) - prefix_sum(i - 1)
    end

    # The method is 1 based, not 0 based like arrays
    def update(i, val)
      while i < @tree.size
        @tree[i] += val
        i += lsb(i)
      end
    end

    private

    # Subtract the least significant bit
    # -i in binary is just inverting the bits and adding 1
    # side node: Another reminder i + -i = 2^n
    # So, adding 1 to the flipped bits will do the following
    #   * It'll convert every 1 to 0 till we hit a 0
    #   * It'll convert that 0 to 1 and stop
    #   e.g. if 4 = 000000100, then -4 = 11111011 + 1 => 11111100
    # Now, if we do i & -i, the only digit we'll get is the last 0 that was flipped to 1
    # and that 0 was actually 1 in i(it got flipped when doing -i).
    # 1 & 1 = 1, so that is the only 1 we'll get and that value is the right most 1 in i
    # and is thus the least significant bit.
    def lsb(i)
      i & -i
    end
  end
end
