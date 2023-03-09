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

    class TestLongestCommonPrefixArray < Minitest::Test
      def test_all
        lcpa = ::DataStructures::SuffixArray::LongestCommonPrefixArray.new "ABABBAB"

        assert_equal("ABABBAB", lcpa.string)
        assert_equal([0, 2, 2, 0, 1, 3, 1], lcpa.arr)
        assert_equal(19, lcpa.unique_substrings_count)
      end
    end
  end
end
