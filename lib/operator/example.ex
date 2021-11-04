defmodule Operator.Example do
  @moduledoc "Example for testing & teaching."

  use Operator

  @operator :~>
  @doc "Operator alias definition"
  @spec divide(number, number) :: number
  def divide(a, b), do: a / b

  @operator :~~~
  @doc "Unary operator"
  @spec negative(number) :: number
  def negative(e), do: -e

  @doc "Example of no operator"
  @spec add(number, number) :: number
  def add(c, d), do: c + d

  @operator :<~>
  @doc "Example of a different operator"
  @spec multiply(number, number) :: number
  def multiply(x, y), do: x * y
end
