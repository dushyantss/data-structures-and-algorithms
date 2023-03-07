# frozen_string_literal: true

module DataStructures
  # SuffixArray is a data structure that allows for fast substring queries in a
  # string. It is implemented using the suffix array algorithm.
  # It is a space-efficient alternative to a suffix tree.
  # Which in turn is a space-efficient alternative to a trie.
  class SuffixArray
    attr_reader :string, :arr

    def initialize(string)
      @string = string
      @arr = (0...string.length).to_a

      @arr.sort! do |i, j|
        while i < string.length && j < string.length && string[i] == string[j]
          i += 1
          j += 1
        end

        if i == string.length
          -1
        elsif j == string.length
          1
        else
          string[i] <=> string[j]
        end
      end
    end
  end
end
