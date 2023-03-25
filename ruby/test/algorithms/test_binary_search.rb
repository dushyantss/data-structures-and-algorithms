# frozen_string_literal: true

require "test_helper"

module Algorithms
  class TestBinarySearch < Minitest::Test
    def test_everything_cause_i_am_lazy
      array = (1..10).to_a
      subject = Object.new.extend Algorithms::BinarySearch

      assert_equal 2, subject.binary_search(array, 3)
      assert_equal 5, subject.binary_search(array, 6)
      assert_equal 0, subject.binary_search(array, 1)
      assert_nil subject.binary_search(array, 0)
      assert_nil subject.binary_search(array, 11)
    end
  end
end
