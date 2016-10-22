%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "src/", "web/", "apps/", "spec/", "test"],
        excluded: [
          "lib/notarize_mismo.ex",
          "lib/notarize_mismo/mismo/schema.ex",
          "test/views/layout_view_test.exs",
          "test/views/error_view_test.exs",
          "test/views/error_view_test.exs",
          "web/views/changeset_view.ex"
        ]
      },
      checks: [
        {Credo.Check.Consistency.TabsOrSpaces},

        {Credo.Check.Design.AliasUsage, false},
        {Credo.Check.Refactor.PipeChainStart, false},
        {Credo.Check.Warning.NameRedeclarationByDef, false},

        # For others you can also set parameters
        # {Credo.Check.Readability.MaxLineLength, priority: :low, max_length: 100},

        # You can also customize the exit_status of each check.
        # If you don't want TODO comments to cause `mix credo` to fail, just
        # set this value to 0 (zero).
        {Credo.Check.Design.TagTODO, exit_status: 2},
      ]
    }
  ]
}
