defmodule Operator.Example do
  @moduledoc "Example for testing and teaching"

  use Operator

  @operator :~>
  @doc "Operator alias definition"
  @spec divide(number, number) :: number
  def divide(a, b), do: a / b

  @operator :~~~
  @doc "Unary operator"
  @spec negitive(number) :: number
  def negitive(e), do: -e

  @doc "Example of no operator"
  @spec add(number, number) :: number
  def add(c, d), do: c + d

  @operator :<~>
  @doc "Example of a different operator"
  @spec multiply(number, number) :: number
  def multiply(x, y), do: x * y
end
