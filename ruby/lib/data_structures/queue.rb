# frozen_string_literal: true

require "forwardable"

module DataStructures
  # A simple queue
  class Queue
    extend Forwardable

    def_delegators :@ary, :size, :empty?
    def_delegator :@ary, :push, :enqueue
    def_delegator :@ary, :shift, :dequeue

    # @param collection [Array] a collection which will be moved into this
    def initialize(collection = nil)
      self.ary = collection.nil? ? [] : Array.new(collection)
    end

    def peek
      ary[0]
    end

    private

    # @return [Array]
    attr_accessor :ary
  end
end
