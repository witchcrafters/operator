defmodule Operator.Mixfile do
  use Mix.Project

  @source_url "https://github.com/expede/operator"
  @version "0.2.1"

  def project do
    [
      app: :operator,
      name: "Operator",
      description: "Helpers for defining operators",
      version: @version,
      elixir: "~> 1.11",
      package: [
        maintainers: ["Brooklyn Zelenka"],
        licenses: ["MIT"],
        links: %{"GitHub" => @source_url}
      ],
      aliases: [
        quality: [
          "test",
          "credo --strict"
        ]
      ],
      deps: [
        {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
        {:dialyxir, "~> 1.1", only: :dev, runtime: false},
        {:earmark, "~> 1.4", only: :dev, runtime: false},
        {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
        {:inch_ex, "~> 2.0", only: [:dev, :docs, :test], runtime: false}
      ],
      docs: [
        extras: [
          "LICENSE.md": [title: "License"],
          "README.md": [title: "Overview"]
        ],
        main: "readme",
        source_url: @source_url,
        homepage_url: @source_url,
        logo: "./brand/logo.png"
      ]
    ]
  end
end
