defmodule Operator.Example do
  use Operator

  @operator :~>
  def add(a, b), do: a + b

  def multiply(x, y), do: x * y
end
