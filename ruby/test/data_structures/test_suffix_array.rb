# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestSuffixArray < Minitest::Test
    def test_all
      sa = SuffixArray.new "horse"

      assert_equal("horse", sa.string)
      assert_equal([4, 0, 1, 2, 3], sa.arr)

      sa = SuffixArray.new "banana"

      assert_equal("banana", sa.string)
      assert_equal([5, 3, 1, 0, 4, 2], sa.arr)
    end
  end
end
