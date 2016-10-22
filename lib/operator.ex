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
        @operator :~>
        def divide(a, b), do: a / b

        @doc "Multiply two numbers"
        @operator :<~>
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

      Module.register_attribute __MODULE__, :operator, []
    end
  end

  alias __MODULE__

  @doc ~S"""
  Modified `def` that applies the most recent `@operator`

  ## Examples

      # ...
      @operator :<~>
      # ...
      def add(a, b), do: a + b

      add(1, 2)
      #=> 3

      1 <~> 2
      #=> 3

  """
  defmacro def(fun_head, expr \\ nil) do
    quote do
      Operator.dispatch_alias(unquote(fun_head), Operator.get)
      Kernel.def(unquote(fun_head), unquote(expr))
      Operator.unset
    end
  end

  @doc ~S"""
  Define an operator alias for a named function

  ## Examples

      defalias(:max, [], 2, as: :<|>)

      10 <|> 8
      #=> 10

  """
  defmacro defalias(_fun_head, as: nil), do: :ok
  defmacro defalias(fun_head,  as: operator_symbol) do
    {fun, ctx, args} = fun_head
    operator = {operator_symbol, ctx, args}

    quote do
      defdelegate(unquote(operator), to: __MODULE__, as: unquote(fun))
    end
  end

  @doc "Get the current value of `@operator`"
  @spec get() :: nil | atom
  defmacro get do
    quote do: Module.get_attribute(__MODULE__, :operator)
  end

  @doc "Unset `@operator` to prevent operator name collisions"
  @spec unset() :: no_return
  defmacro unset do
    quote do: Module.put_attribute(__MODULE__, :operator, nil)
  end

  @doc ~S"""
  Workaround for `defdelegate` with variables in AST

  This is an ABSURD workaround. Just brute forcing the problem for now.
  Need to revisit, obviously.
  Having difficulty interpolating `a ~> b` into `defdelegate` because
  unquoting tries to fully evaluate what looks like a function call

  The hope is that this function will be able to be removed completely,
  hence isolating it here
  """
  @lint false
  defmacro dispatch_alias(fun_head, operator_symbol) do
    quote do
      case unquote(operator_symbol) do
        nil  -> :ok
        :&   -> defalias(unquote(fun_head), as: :&)
        :&&  -> defalias(unquote(fun_head), as: :&&)
        :&&& -> defalias(unquote(fun_head), as: :&&&)

        :<-  -> defalias(unquote(fun_head), as: :<-)
        :\\  -> defalias(unquote(fun_head), as: :\\)
        :::  -> defalias(unquote(fun_head), as: :::)

        :=   -> defalias(unquote(fun_head), as: :=)
        :==  -> defalias(unquote(fun_head), as: :==)
        :!=  -> defalias(unquote(fun_head), as: :!=)
        :=~  -> defalias(unquote(fun_head), as: :=~)

        :=== -> defalias(unquote(fun_head), as: :===)
        :!== -> defalias(unquote(fun_head), as: :!==)

        :|   -> defalias(unquote(fun_head), as: :|)
        :||  -> defalias(unquote(fun_head), as: :||)
        :||| -> defalias(unquote(fun_head), as: :|||)

        :>   -> defalias(unquote(fun_head), as: :>)
        :<   -> defalias(unquote(fun_head), as: :<)
        :<=  -> defalias(unquote(fun_head), as: :<=)
        :>=  -> defalias(unquote(fun_head), as: :>=)

        :|>  -> defalias(unquote(fun_head), as: :|>)

        :~>  -> defalias(unquote(fun_head), as: :~>)
        :~>> -> defalias(unquote(fun_head), as: :~>>)
        :>>> -> defalias(unquote(fun_head), as: :>>>)

        :<~  -> defalias(unquote(fun_head), as: :<~)
        :<<~ -> defalias(unquote(fun_head), as: :<<~)
        :<<< -> defalias(unquote(fun_head), as: :<<<)

        :<~> -> defalias(unquote(fun_head), as: :<~>)
        :<|> -> defalias(unquote(fun_head), as: :<|>)

        :^ -> defalias(unquote(fun_head), as: :^)
        :^^^ -> defalias(unquote(fun_head), as: :^^^)
        :<>  -> defalias(unquote(fun_head), as: :<>)

        :+   -> defalias(unquote(fun_head), as: :+)
        :++  -> defalias(unquote(fun_head), as: :++)
        :-   -> defalias(unquote(fun_head), as: :-)
        :--  -> defalias(unquote(fun_head), as: :--)

        :*   -> defalias(unquote(fun_head), as: :*)
        :/   -> defalias(unquote(fun_head), as: :/)
        :!   -> defalias(unquote(fun_head), as: :!)
        :^   -> defalias(unquote(fun_head), as: :^)

        :~~~ -> defalias(unquote(fun_head), as: :~~~)
        :.   -> defalias(unquote(fun_head), as: :.)
        :..  -> defalias(unquote(fun_head), as: :..)
        :@   -> defalias(unquote(fun_head), as: :@)

        :when   -> defalias(unquote(fun_head), as: :when)
        :in   -> defalias(unquote(fun_head), as: :in)

        :and   -> defalias(unquote(fun_head), as: :and)
        :or   -> defalias(unquote(fun_head), as: :or)

        :not   -> defalias(unquote(fun_head), as: :not)
      end
    end
  end
end
