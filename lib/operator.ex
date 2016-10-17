defmodule Operator do
  @moduledoc ~S"""
  Helpers for defining operator aliases for functions

  Operators can be hard to follow, especially with the limited number available
  in Elixir. Always having a named function backing an operator makes it easy to
  fall back to the named version. Named fall backs are also very useful for
  piping (`|>`).

  ## Examples

      defmodule Example do
        use Operator

        @doc "Divide two numbers"
        @operator a ~> b
        def divide(a, b), do: a / b

        @doc "Multiply two numbers"
        @operator a <~> b
        def multiply(a, b), do: a * b
      end

      import Example

      divide(10, 5)
      #=> 5

      10 ~> 2
      #=> 5

      multiply(10, 2)
      #=> 20

      10 <~> 2
      #=> 20

  """

  defmacro __using__(_) do
    quote do
      import Kernel, except: [def: 2]

      require unquote(__MODULE__)
      import  unquote(__MODULE__)
    end
  end

  @doc ~S"""
  Modified `def` that applies the most recent `@operator`

  ## Examples

      @operator x <~> y
      # ...
      def add(a, b), do: a + b

      add(1, 2)
      #=> 3

      1 <~> 2
      #=> 3

  """
  @spec def(any, nil | any) :: expression
  defmacro def(call, expr \\ nil) do
    quote do
      if @operator, do: defalias(call, as: @operator)
      Kernel.def(call, expr)
      @operator nil # Unset @operator
    end
  end

  @doc ~S"""
  Define an operator alias for a named function

  ## Examples

      defalias(max, a <|> b)

      10 <|> 8
      #=> 10

  """
  @spec defalias(atom, as: any) :: any
  defmacro defalias(fun_name, as: op_expression) do
    quote do
      defdelegate unquote(op_expression), to: __MODULE__, as: unquote(fun_name)
    end
  end
end
