# frozen_string_literal: true

require "forwardable"

module DataStructures
  # LongestCommonPrefixArray is a data structure that tracks how many characters
  # two sorted adjacent suffixes have in common in the prefix.
  class LongestCommonPrefixArray
    extend Forwardable

    # @return [Array] the array of longest common prefix values
    attr_reader :arr

    # @return [SuffixArray] the suffix array that this array is built on
    attr_reader :sa

    def_delegator :sa, :string

    def initialize(string)
      @sa = SuffixArray.new(string)
      @arr = Array.new(string.length, 0)

      i = 1
      @sa.arr.each_cons(2) do |a, b|
        sum = 0
        while a < string.length && b < string.length && string[a] == string[b]
          sum += 1

          a += 1
          b += 1
        end

        @arr[i] = sum
        i += 1
      end
    end
  end
end
