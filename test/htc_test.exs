defmodule HtcTest do
  use ExUnit.Case
  alias Htc.Node
  doctest Htc

  test "build tree" do
    array = [[1], [1,2], [1,2,3]]
    tree = %Node{value: 1,
                 children: %{left: %Node{value: 1,
                                         children: %{left: %Node{value: 1, children: nil},
                                                     right: %Node{value: 2, children: nil}}},
                             right: %Node{value: 2,
                                          children: %{left: %Node{value: 2, children: nil},
                                                      right: %Node{value: 3, children: nil}}}}}
    assert Htc.build_tree(array) == tree
  end

  test "validate triangle" do
    assert Htc.is_triangle?([[1], [1,2], [1,2,3]])
  end

  test "not a triangle" do
    assert Htc.is_triangle?([1,2,3]) == false
  end
  test "definetely not a triangle" do
    assert Htc.is_triangle?("circle") == false
  end

  test "regular triangle" do
    example = [[6],[3,5],[9,7,1],[4,6,8,4]]
    assert Htc.max_sum(example) == {:ok, 26}
  end

  test "does it work with floats?" do
    example = [[6.5],[3.7,5.4],[9.3,7.1,1.7],[4.4,6.3,8.4,4]]
    assert Htc.max_sum!(example) == 27.4
  end

  test "triangle with more than one value at the top layer" do
    example = [[3,5],[9,7,1],[4,6,8,4]]
    assert Htc.max_sum(example) == {:ok, 20}
  end
end
