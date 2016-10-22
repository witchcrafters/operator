defmodule Operator.Example do
  @lint false
  use Operator

  @operator :~>
  def add(a, b), do: a + b

  @operator :<~>
  def multiply(x, y), do: x * y
end
