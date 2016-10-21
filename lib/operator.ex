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

      @operator x <~> y
      # ...
      def add(a, b), do: a + b

      add(1, 2)
      #=> 3

      1 <~> 2
      #=> 3

  """
  defmacro def(head, expr \\ nil) do
    {fun_name, ctx, args} = head

    quote do
      # This is SO STUPID. Just brute forcing the problem for now. Need to revisit.
      # The problem is that passing Operator.get to defalias (or defdelegate)
      # tried to insert the *literal* Operator.get, rather than evaluating it first.
      # Same happens with anonymous functions.
      case Operator.get do
        :&   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :&)
        :&&  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :&&)
        :&&& -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :&&&)

        :<-  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :<-)
        :::  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :::)

        :==  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :==)
        :!=  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :!=)

        :=== -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :===)
        :!== -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :!==)

        :|   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :|)
        :||  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :||)
        :||| -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :|||)

        :>   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :>)
        :<   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :<)
        :<=  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :<=)
        :>=  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :>=)

        :|>  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :|>)

        :~>  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :~>)
        :~>> -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :~>>)
        :>>> -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :>>>)

        :<~  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :<~)
        :<<~ -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :<<~)
        :<<< -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :<<<)

        :<~> -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :<~>)
        :<|> -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :<|>)

        :^^^ -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :^^^)
        :<>  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :<>)

        :+   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :+)
        :++  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :++)
        :-   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :-)
        :--  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :--)

        :*   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :*)
        :/   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :/)
        :!   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :!)
        :^   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :^)

        :~~~ -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :~~~)
        :.   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :.)
        :..  -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :..)
        :@   -> defalias(unquote(fun_name), unquote(ctx), unquote(args), as: :@)
      end

      Kernel.def(unquote(head), unquote(expr))
      Operator.unset
    end
  end

  @doc ~S"""
  Define an operator alias for a named function

  ## Examples

      defalias(max, 2, as: :<|>)

      10 <|> 8
      #=> 10

  """
  defmacro defalias(_, _, _, as: nil), do: :ok
  defmacro defalias(fun_name, ctx, args, as: operator) do
    quote do
      defdelegate(unquote({operator, ctx, args}), to: __MODULE__, as: unquote(fun_name))
    end
  end

  @spec get() :: nil | atom
  defmacro get do
    quote do: Module.get_attribute(__MODULE__, :operator)
  end

  @spec unset() :: no_return
  defmacro unset do
    quote do: Module.put_attribute(__MODULE__, :operator, nil)
  end
end
