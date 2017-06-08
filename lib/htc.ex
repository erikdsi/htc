defmodule Htc do

  defmodule Node do
    defstruct value: 0, children: nil
  end

  def create_node(element, index, tail) when is_binary(element) do
    with {value, _} <- Float.parse(element) do
      create_node(value, index, tail)
    else
      :error -> {:error, "couldn't parse element #{element} as number"}
    end
  end
  def create_node(element, _, []) do
    {:ok, %Node{value: element}}
  end
  def create_node(element, index, tail) when is_number(element) do
    [children | tail] = tail
    lni = index # left node index
    rni = index+1 # right node index
    with {:ok, left_node} <- create_node(Enum.at(children, lni), lni, tail),
         {:ok, right_node} <- create_node(Enum.at(children, rni), rni, tail) do
      {:ok, %Node{value: element, children: %{left: left_node, right: right_node}}}
    else
      error -> error
    end

  end

  @doc """
  Turns the triangle in list format to binary tree
  Creates a 0 value root node for triangles
  with more than one element at the top layer
  """
  def build_tree(list) do
    if is_triangle?(list) do
      [top | tail]  = list
      if length(top) == 1 do
        create_node(Enum.at(top, 0), 0, tail)
      else
        create_node(0, 0, list)
      end
    else
      {:error, "Can't parse input as triangle"}
    end

  end

  @doc """
  Returns the total maximum sum for a given tree
  """
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
  Returns true if each layer has one more element than previous layer
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
    {:ok, tree} = build_tree(list)
    node_sum(tree)
  end

  def max_sum(list) do
    with {:ok, tree} <- build_tree(list) do
      {:ok, node_sum(tree)}
    else
      error -> error
    end
  end

end
