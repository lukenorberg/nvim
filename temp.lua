require("core.keymaps")
require("core.lazy")
require("core.options")
vim.cmd('syntax enable')

require("lazy").setup({
    "folke/which-key.nvim",
    'windwp/nvim-autopairs',
    "williamboman/mason-lspconfig.nvim",
    'nvim-treesitter/nvim-treesitter',
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
    'nvim-lua/plenary.nvim',
      "folke/neodev.nvim",
      {
        'neovim/nvim-lspconfig',
        opts = {
            servers = { 
                eslint = {
                    settings = {
                      workingDirectories = { mode = "auto" },
                },
              },
            },
        }
      },
      { "folke/neoconf.nvim", cmd = "Neoconf" },
    { "rose-pine/neovim", name = "rose-pine" },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end
    },
})

local wk = require("which-key")
wk.register(mappings, opts)
require("mason").setup()
require("nvim-treesitter").setup({
     highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "luadoc",
      "markdown",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "xml",
      "yaml",
    },
})
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "tsserver", "pyright", "eslint" }
}

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
    --    null_ls.builtins.diagnostics.eslint,
       null_ls.builtins.formatting.prettier,
--        null_ls.builtins.formatting.stylua,
--       null_ls.builtins.completion.spell,
 --       require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
    },
})
require("rose-pine").setup({
    variant = "auto", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
    },

    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },

    groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
    },

    highlight_groups = {
        -- Comment = { fg = "foam" },
        -- VertSplit = { fg = "muted", bg = "muted" },
    },

    before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
    end,
})

vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme rose-pine-main")
-- vim.cmd("colorscheme rose-pine-moon")
-- vim.cmd("colorscheme rose-pine-dawn")
require'lspconfig'.tsserver.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.lua_ls.setup{
    settings = {
        diagnostics = {
            globals = {
                "vim",
                "require"
            }
        },
      telemetry = {
        enable = false,
      },
    }

}
