# frozen_string_literal: true

module Algorithms
  # Quick sort
  module QuickSort
    def quick_sort(arr, low = 0, high = arr.length - 1)
      return if low >= high

      pivot = partition(arr, low, high)
      quick_sort(arr, low, pivot - 1)
      quick_sort(arr, pivot + 1, high)
    end

    def partition(arr, low, high)
      i = low
      j = high

      pivot_value = arr[low]

      while i < j
        i += 1 while i < high && arr[i] <= pivot_value
        j -= 1 while j >= low && arr[j] > pivot_value
        arr[i], arr[j] = arr[j], arr[i] if i < j
      end

      arr[low], arr[j] = arr[j], arr[low]

      j
    end
  end
end
