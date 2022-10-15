# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestMinHeapList < Minitest::Test
    def test_initialize_and_pop
      heap = MinHeap.new([11, 123, 1])

      assert_equal 1, heap.pop
      assert_equal 11, heap.pop
      assert_equal 123, heap.pop
    end

    def test_push
      heap = MinHeap.new

      heap << 11
      heap << 12_223
      heap << 1
      assert_equal 1, heap.peek
    end

    def test_peek
      heap = MinHeap.new([11, 123, 1])

      assert_equal 1, heap.peek
    end

    def test_remove
      heap = MinHeap.new([11, 123, 1])

      val = heap.remove 1

      assert_equal 1, val
      assert_equal 2, heap.length
      assert_equal 11, heap.pop
      assert_equal 123, heap.pop
    end
  end

  class TestMaxHeapList < Minitest::Test
    def test_initialize_and_pop
      heap = MaxHeap.new([11, 123, 1])

      assert_equal 123, heap.pop
      assert_equal 11, heap.pop
      assert_equal 1, heap.pop
    end

    def test_push
      heap = MaxHeap.new

      heap << 11
      heap << 12_223
      heap << 1
      assert_equal 12_223, heap.peek
    end

    def test_peek
      heap = MaxHeap.new([11, 123, 1])

      assert_equal 123, heap.peek
    end

    def test_remove
      heap = MaxHeap.new([11, 123, 1])

      val = heap.remove 1

      assert_equal 1, val
      assert_equal 2, heap.length
      assert_equal 123, heap.pop
      assert_equal 11, heap.pop
    end
  end
end
