![](https://raw.githubusercontent.com/expede/operator/master/brand/logo.png)

[![Build Status](https://travis-ci.org/expede/operator.svg?branch=master)](https://travis-ci.org/expede/operator)
[![Module Version](https://img.shields.io/hexpm/v/operator.svg)](https://hex.pm/packages/operator)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/operator/)
[![Total Download](https://img.shields.io/hexpm/dt/operator.svg)](https://hex.pm/packages/operator)
[![License](https://img.shields.io/hexpm/l/operator.svg)](https://github.com/expede/operator/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/expede/operator.svg)](https://github.com/expede/operator/commits/master)

Helpers for defining operator aliases for functions.

## Quick Start

```elixir

def deps do
  [
    {:operator, "~> 0.2.0"}
  ]
end

defmodule MyModule do
  use Operator

  @operator :~>
  # ...
end
```

## Summary

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

## Operator Reference

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
| `\|`     |                    |                        | :heavy_check_mark:      |
| `\|\|`   |                    | :heavy_check_mark:     |                         |
| `\|\|\|` |                    | :heavy_check_mark:     |                         |
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
| `\|>`    |                    | :heavy_check_mark:     |                         |
| `<\|>`   |                    | :heavy_check_mark:     |                         |
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


## Copyright and License

Copyright (c) 2016 Brooklyn Zelenka

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.
