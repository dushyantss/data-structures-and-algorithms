# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestRubyDoublyLinkedList < Minitest::Test
    def test_each
      list = list_with_dummy_data

      assert_equal [1, 2, 3], list.map(&:itself)
    end

    def test_reverse_each
      list = list_with_dummy_data

      assert_equal [3, 2, 1], list.reverse_each.map(&:itself)
    end

    def test_inspect
      list = list_with_dummy_data

      assert_equal "[1, 2, 3]", list.inspect
    end

    def test_to_s
      list = list_with_dummy_data

      assert_equal "[1, 2, 3]", list.to_s
    end

    def test_equality
      list = list_with_dummy_data
      list2 = list_with_dummy_data

      assert_equal list, list2
    end

    def test_index_based_retrieval
      list = list_with_dummy_data

      assert_equal 1, list[0]
      assert_equal 1, list.at(0)
    end

    def test_index_based_setting_value
      list = list_with_dummy_data

      list[0] = 3

      assert_equal 3, list[0]
    end

    def test_first
      list = list_with_dummy_data

      assert_equal 1, list.first
      assert_equal [1, 2], list.first(2)
    end

    def test_last
      list = list_with_dummy_data

      assert_equal 3, list.last
      assert_equal [2, 3], list.last(2)
    end

    def test_concat
      list = list_with_dummy_data

      # rubocop:disable Style/ConcatArrayLiterals
      assert_equal [1, 2, 3, 1, 2, 3], list.concat([1, 2, 3]).to_a
      # rubocop:enable Style/ConcatArrayLiterals
    end

    def test_clear
      list = list_with_dummy_data

      list.clear

      assert_empty list
    end

    def test_empty?
      list = list_with_dummy_data

      refute_empty list
    end

    def test_append_push_pop_shift_unshift
      list = list_with_dummy_data
      list << 1

      assert_equal 1, list.last

      list.push 2

      assert_equal 2, list.last

      assert_equal 2, list.pop
      assert_equal 1, list.last

      list.unshift 2

      assert_equal 2, list.first

      assert_equal 2, list.shift
      assert_equal 1, list.first
    end

    def test_remove_at
      list = list_with_dummy_data

      assert_equal 2, list.remove_at(1)
      assert_equal [1, 3], list.to_a
    end

    def test_remove
      list = list_with_dummy_data

      assert_equal 2, list.remove(2)
      assert_equal [1, 3], list.to_a
    end

    private

    def list_with_dummy_data
      list = RubyDoublyLinkedList.new
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
