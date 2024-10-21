return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.highlight = {
      enable = true,
      disable = { "latex" },
    }
    require("nvim-treesitter.configs").setup(opts)
  end,
}
