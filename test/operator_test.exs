defmodule Operator.DocTest do
  use ExUnit.Case
  import Operator.Example

  test "base" do
    assert add(1, 2) == 3
  end

  test "the truth" do
    assert (1 ~> 2) == 3
  end

  test "the truth 2" do
    assert (10 <~> 2) == 20
  end
end
