return {
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
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
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                    end
                end,
                additional_vim_regex_highlighting = false,
              },
        })
        end,
    }
}
