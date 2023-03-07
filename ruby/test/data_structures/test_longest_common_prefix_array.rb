# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestLongestCommonPrefixArray < Minitest::Test
    def test_all
      lcpa = LongestCommonPrefixArray.new "ABABBAB"

      assert_equal("ABABBAB", lcpa.string)
      assert_equal([0, 2, 2, 0, 1, 3, 1], lcpa.arr)
    end
  end
end
