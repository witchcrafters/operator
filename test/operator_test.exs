defmodule Operator.DocTest do
  use ExUnit.Case

  import Operator.Example

  test "Named function is available" do
    assert divide(1, 2) == 0.5
  end

  test "Operator functions the same as the named function" do
    assert 1 ~> 2 == divide(1, 2)
  end

  test "Multiple functions with different aliases" do
    assert (10 <~> 2) == multiply(10, 2)
  end

  test "Unary operators" do
    assert ~~~6 == negative(6)
  end

  test "Operator is optional (can define normal function)" do
    assert add(5, 2) == 7
  end
end
