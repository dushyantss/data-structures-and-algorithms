# frozen_string_literal: true

# Algorithms is the top level module for all algorithms
module Algorithms
  # Merge sort
  # low can never be greater than high
  def self.merge_sort(arr, low = 0, high = arr.length - 1)
    return [arr[low]] if low == high

    mid = (low + high) / 2
    left = merge_sort(arr, low, mid)
    right = merge_sort(arr, mid + 1, high)
    merge(left, right)
  end

  def self.merge(left, right)
    result = []
    i = 0
    j = 0

    while i < left.length && j < right.length
      if left[i] < right[j]
        result << left[i]
        i += 1
      else
        result << right[j]
        j += 1
      end
    end

    while i < left.length
      result << left[i]
      i += 1
    end

    while j < right.length
      result << right[j]
      j += 1
    end

    result
  end
end
