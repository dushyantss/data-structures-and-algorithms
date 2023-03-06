# frozen_string_literal: true

require "test_helper"

module DataStructures
  class TestUnionFind < Minitest::Test
    def test_kruskal
      union_find = UnionFind.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

      union_find.union(1, 2)

      assert_equal 2, union_find.find(1)
      assert_equal 2, union_find.find(2)

      union_find.union(3, 4)

      assert_equal 4, union_find.find(3)
      assert_equal 4, union_find.find(4)

      union_find.union(5, 6)

      assert_equal 6, union_find.find(5)
      assert_equal 6, union_find.find(6)

      union_find.union(7, 8)

      assert_equal 8, union_find.find(7)
      assert_equal 8, union_find.find(8)

      union_find.union(9, 10)

      assert_equal 10, union_find.find(9)
      assert_equal 10, union_find.find(10)

      union_find.union(1, 3)

      assert_equal 4, union_find.find(1)
      assert_equal 4, union_find.find(2)
      assert_equal 4, union_find.find(3)
      assert_equal 4, union_find.find(4)

      union_find.union(9, 1)

      assert_equal 4, union_find.find(1)
      assert_equal 4, union_find.find(2)
      assert_equal 4, union_find.find(3)
      assert_equal 4, union_find.find(4)
      assert_equal 4, union_find.find(9)
      assert_equal 4, union_find.find(10)

      union_find.union(5, 9)

      assert_equal 4, union_find.find(1)
      assert_equal 4, union_find.find(2)
      assert_equal 4, union_find.find(3)
      assert_equal 4, union_find.find(4)
      assert_equal 4, union_find.find(5)
      assert_equal 4, union_find.find(6)
      assert_equal 4, union_find.find(9)
      assert_equal 4, union_find.find(10)

      union_find.union(7, 8)
      union_find.union(7, 8)
      union_find.union(7, 8)

      assert_equal 8, union_find.find(7)
      assert_equal 8, union_find.find(8)
    end
  end
end
