# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestDoublyLinkedList < Minitest::Test
    def test_remove_first
      list = list_with_dummy_data

      val = list.remove_first

      assert_equal 1, val
      assert_equal 2, list.size
    end

    def test_remove_last
      list = list_with_dummy_data

      val = list.remove_last

      assert_equal 3, val
      assert_equal 2, list.size
    end

    def test_remove_at
      list = large_list_with_dummy_data

      val = list.remove_at(3)

      assert_equal 4, val
      assert_equal 5, list.size

      val = list.remove_at(1)

      assert_equal 2, val
      assert_equal 4, list.size
    end

    def test_index_of
      list = large_list_with_dummy_data

      val = list.index_of(3)

      assert_equal 2, val
      assert_equal 6, list.size
    end

    def test_remove
      list = large_list_with_dummy_data

      val = list.remove(3)

      assert_equal 3, val
      assert_equal 5, list.size
    end

    def test_contains
      list = large_list_with_dummy_data

      assert list.contains(3)
      refute list.contains(36)
    end

    private

    def list_with_dummy_data
      list = DoublyLinkedList.new
      list << 1
      list << 2
      list << 3
      list
    end

    def large_list_with_dummy_data
      list = list_with_dummy_data
      list << 4
      list << 5
      list << 6
      list
    end
  end
end
