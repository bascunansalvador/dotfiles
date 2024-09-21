return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = { kotlin = { "ktlint" } },
  },
  config = function()
      require("conform").setup()
    end,
}
