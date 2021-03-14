defmodule Operator.Mixfile do
  use Mix.Project

  def project do
    [
      app:  :operator,
      name: "Operator",

      description: "Helpers for defining operators",
      version: "0.2.1",
      elixir:  "~> 1.11",

      package: [
        maintainers: ["Brooklyn Zelenka"],
        licenses:    ["MIT"],
        links:       %{"GitHub" => "https://github.com/expede/operator"}
      ],

      source_url:   "https://github.com/expede/operator",
      homepage_url: "https://github.com/expede/operator",

      aliases: [
        quality: [
          "test",
          "credo --strict"
        ]
      ],

      deps: [
        {:credo,    "~> 1.5",  only: [:dev, :test], runtime: false},

        {:dialyxir, "~> 1.1",  only: :dev, runtime: false},
        {:earmark,  "~> 1.4",  only: :dev, runtime: false},
        {:ex_doc,   "~> 0.23", only: :dev, runtime: false},

        {:inch_ex,  "~> 2.0",  only: [:dev, :docs, :test], runtime: false}
      ],

      docs: [
        extras: ["README.md"],
        logo: "./brand/logo.png",
        main: "readme"
      ]
    ]
  end
end
