# frozen_string_literal: true

require "forwardable"

module DataStructures
  # A simple stack
  class Stack
    extend Forwardable

    def_delegators :@ary, :size, :empty?, :push, :pop

    # @param collection [Array] a collection which will be moved into this
    def initialize(collection = nil)
      self.ary = collection.nil? ? [] : Array.new(collection)
    end

    def peek
      ary[-1]
    end

    private

    # @return [Array]
    attr_accessor :ary
  end
end
