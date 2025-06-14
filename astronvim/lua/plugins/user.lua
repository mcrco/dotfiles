-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    enabled = false,
    -- config = function(plugin, opts)
    --   require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
    --   -- add more custom luasnip configuration such as filetype extend or custom snippets
    --   local luasnip = require "luasnip"
    --   luasnip.filetype_extend("javascript", { "javascriptreact" })
    -- end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "SirVer/ultisnips",
    event = { "InsertEnter" },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "quangnguyen30192/cmp-nvim-ultisnips",
      "hrsh7th/cmp-omni",
    },
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require "cmp"
      -- modify the sources part of the options table
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
        { name = "ultisnips", priority = 700 }, -- add new source
      }
      opts.snippet = {
        expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end,
      }
      local cmp_ultisnips_mappings = require "cmp_nvim_ultisnips.mappings"

      local function tab_complete(fallback)
        if vim.fn.pumvisible() == 1 then
          cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
        elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
          cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        else
          fallback()
        end
      end

      local function shift_tab_complete(fallback)
        if vim.fn.pumvisible() == 1 then
          cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
        elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
          cmp_ultisnips_mappings.expand_or_jump_backwards(fallback)
        else
          fallback()
        end
      end

      opts.mapping = {
        ["<Tab>"] = cmp.mapping(tab_complete, {
          "i",
          "s", --[[ "c" (to enable the mapping in command mode) ]]
        }),
        ["<S-Tab>"] = cmp.mapping(shift_tab_complete, {
          "i",
          "s", --[[ "c" (to enable the mapping in command mode) ]]
        }),
      }

      vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"

      cmp.setup(opts)

      -- No buffer text for latex + text wrap
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function(t)
          opts.sources = cmp.config.sources {
            { name = "nvim_lsp", priority = 1000 },
            { name = "path", priority = 250 },
            { name = "ultisnips", priority = 700 }, -- add new source
            { name = "omni", priority = 700 }, -- add new source
          }
          cmp.setup(opts)
        end,
      })
    end,
  },
  {
    "lervag/vimtex",
    init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_compiler_latexmk = {
        out_dir = "build",
      }
      vim.g.vimtex_view_method = "zathura"
    end,
    event = "BufRead",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.highlight = {
        enable = true,
        disable = { "latex" },
      }
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
