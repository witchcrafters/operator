defmodule Operator.Example do
  @moduledoc "Example for testing and teaching"

  use Operator

  @doc "Operator alias definition"
  @operator :~>
  @spec divide(number, number) :: number
  def divide(a, b), do: a / b

  @doc "Unary operator"
  @operator :~~~
  @spec negitive(number) :: number
  def negitive(e), do: -e

  @doc "Example of no operator"
  @spec add(number, number) :: number
  def add(c, d), do: c + d

  @doc "Example of a different operator"
  @operator :<~>
  @spec multiply(number, number) :: number
  def multiply(x, y), do: x * y
end
