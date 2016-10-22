# Operator

[![Build Status](https://travis-ci.org/expede/operator.svg?branch=master)](https://travis-ci.org/expede/operator) [![Inline docs](http://inch-ci.org/github/expede/operator.svg?branch=master)](http://inch-ci.org/github/expede/operator) [![Deps Status](https://beta.hexfaktor.org/badge/all/github/expede/operator.svg)](https://beta.hexfaktor.org/github/expede/operator) [![hex.pm version](https://img.shields.io/hexpm/v/operator.svg?style=flat)](https://hex.pm/packages/operator) [![API Docs](https://img.shields.io/badge/api-docs-yellow.svg?style=flat)](http://hexdocs.pm/operator/) [![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/expede/operator/blob/master/LICENSE)

# Quick Start

```elixir

def deps do
  [{:operator, "~> 0.1.0"}]
end

defmodule MyModule do
  use Operator

  @operator :~>
  # ...
end
```

# Summary

Helpers for defining operator aliases for functions

Operators can be hard to follow, especially with the limited number available
in Elixir. Always having a named function backing an operator makes it easy to
fall back to the named version. Named fall backs are also very useful for
piping (`|>`).

```elixir

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

```

# Operator Reference

Elixir has a limited number of available operators. Many of them are already used
by `Kernel` (the standard lib). You _can_ overwrite the standard definition
by excluding it from the import of `Kernel`, but this is not advisable
(except in very exceptional cases), because it can be very confusing for users.

Some operators have multiple arities, and can be defined separately.
Some binary operators associate to the left, and others to the right.
Please refer to the table below.

| Operator | Unary              | Left-associated Binary | Right-associated Binary |
|:--------:|:------------------:|:----------------------:|:-----------------------:|
| `!`      | :heavy_check_mark: |                        |                         |
| `@`      | :heavy_check_mark: |                        |                         |
| `.`      |                    | :heavy_check_mark:     |                         |
| `..`     |                    |                        | :heavy_check_mark:      |
| `+`      | :heavy_check_mark: | :heavy_check_mark:     |                         |
| `++`     |                    |                        | :heavy_check_mark:      |
| `-`      | :heavy_check_mark: | :heavy_check_mark:     |                         |
| `--`     |                    |                        | :heavy_check_mark:      |
| `*`      |                    | :heavy_check_mark:     |                         |
| `/`      |                    | :heavy_check_mark:     |                         |
| `^`      | :heavy_check_mark: |                        |                         |
| `^^^`    |                    | :heavy_check_mark:     |                         |
| `~~~`    | :heavy_check_mark: |                        |                         |
| `&`      | :heavy_check_mark: |                        |                         |
| `&&`     |                    | :heavy_check_mark:     |                         |
| `&&&`    |                    | :heavy_check_mark:     |                         |
| `<-`     |                    | :heavy_check_mark:     |                         |
| `\\`     |                    | :heavy_check_mark:     |                         |
| `|`      |                    |                        | :heavy_check_mark:      |
| `||`     |                    | :heavy_check_mark:     |                         |
| `|||`    |                    | :heavy_check_mark:     |                         |
| `=`      |                    |                        | :heavy_check_mark:      |
| `=~`     |                    | :heavy_check_mark:     |                         |
| `==`     |                    | :heavy_check_mark:     |                         |
| `===`    |                    | :heavy_check_mark:     |                         |
| `!=`     |                    | :heavy_check_mark:     |                         |
| `!==`    |                    | :heavy_check_mark:     |                         |
| `<`      |                    | :heavy_check_mark:     |                         |
| `>`      |                    | :heavy_check_mark:     |                         |
| `<>`     |                    |                        | :heavy_check_mark:      |
| `<=`     |                    | :heavy_check_mark:     |                         |
| `>=`     |                    | :heavy_check_mark:     |                         |
| `|>`     |                    | :heavy_check_mark:     |                         |
| `<|>`    |                    | :heavy_check_mark:     |                         |
| `<~>`    |                    | :heavy_check_mark:     |                         |
| `~>`     |                    | :heavy_check_mark:     |                         |
| `~>>`    |                    | :heavy_check_mark:     |                         |
| `>>>`    |                    | :heavy_check_mark:     |                         |
| `<~`     |                    | :heavy_check_mark:     |                         |
| `<<~`    |                    | :heavy_check_mark:     |                         |
| `<<<`    |                    | :heavy_check_mark:     |                         |
| `when`   |                    |                        | :heavy_check_mark:      |
| `in`     |                    | :heavy_check_mark:     |                         |
| `and`    |                    | :heavy_check_mark:     |                         |
| `or`     |                    | :heavy_check_mark:     |                         |
| `not`    |                    | :heavy_check_mark:     |                         |
