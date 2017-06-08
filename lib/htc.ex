defmodule Htc do

  defmodule Node do
    defstruct value: 0, children: nil
  end

  def create_node(element, _, []) do
    %Node{value: element}
  end
  def create_node(element, index, tail) when is_number(element) do
    [children | tail] = tail
    lni = index # left node index
    rni = index+1 # right node index
    %Node{value: element,
          children: %{left: create_node(Enum.at(children, lni), lni, tail),
                      right: create_node(Enum.at(children, rni), rni, tail)}}
  end

  def build_tree([[top] | tail]) do
    create_node(top, 0, tail)
  end
  @doc """
  Creates a 0 value root node for triangles
  with more than one element at the top layer
  """
  def build_tree(list) do
    create_node(0, 0, list)
  end

  def node_sum(%{value: value, children: nil}) do
    value
  end
  def node_sum(%{value: value, children: %{left: left, right: right}}) do
    if node_sum(left) > node_sum(right) do
      value + node_sum(left)
    else
      value + node_sum(right)
    end
  end

  @doc """
  Layers should have one more element than previous layer
  for it to be considered a triangle
  """
  def is_triangle?([_]) do
    true
  end
  def is_triangle?([head | tail]) do
    next = Enum.at(tail, 0)
    is_list(next) and (length(head)+1 == length(next)) and is_triangle?(tail)
  end
  def is_triangle?(_) do
    false
  end

  def max_sum!(list) do
    list
    |> build_tree
    |> node_sum
  end

  def max_sum(list) do
    if is_triangle?(list) do
      {:ok, max_sum!(list)}
    else
      {:error, "Input doesn't look like a triangle"}
    end
  end

end
