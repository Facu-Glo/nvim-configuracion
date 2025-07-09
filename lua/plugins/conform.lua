return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                rust = { "rustfmt", lsp_format = "fallback" },
                javascript = { "prettier", stop_after_first = true },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
                yaml = { "prettier" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                python = { "ruff_format" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters = {
                ruff_format = {
                    command = "ruff",
                    args = { "format", "--line-length", "88", "--stdin-filename", "$FILENAME", "-" },
                    stdin = true,
                },
                prettier = {
                    prepend_args = { "--tab-width", "2", "--no-semi", "--single-quote" },
                },
                clang_format = {
                    command = "clang-format",
                    args = {
                        [[--style={
                            BasedOnStyle: LLVM,
                            IndentWidth: 8,
                            UseTab: ForIndentation,
                            ContinuationIndentWidth: 8,
                            ColumnLimit: 80,
                            SortIncludes: false,
                            BreakBeforeBraces: Linux,
                            PointerAlignment: Right,
                            DerivePointerAlignment: false,
                            SpaceAfterCStyleCast: true,
                            SpacesInCStyleCastParentheses: false,
                            BinPackArguments: false,
                            BinPackParameters: false,
                            IndentCaseLabels: false,
                            Cpp11BracedListStyle: false,
                            MaxEmptyLinesToKeep: 2,
                            AlignTrailingComments: true,
                            SpacesBeforeTrailingComments: 2,
                            KeepEmptyLinesAtTheStartOfBlocks: false,
                            AllowShortIfStatementsOnASingleLine: false,
                            AlwaysBreakAfterReturnType: TopLevelDefinitions,
                            PenaltyExcessCharacter: 7,
                            PenaltyBreakBeforeFirstCallParameter: 50
                          }]]
                    },
                },
            },
        })
    end,
}
