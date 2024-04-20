return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                view = {


                },
                mapping = {
                   -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                   -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<CR>"] = cmp.mapping.confirm {
                      behavior = cmp.ConfirmBehavior.Insert,
                      select = true,
                    },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                        cmp.select_next_item()
                      elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                      else
                        fallback()
                      end
                    end, { "i", "s" }),

                  ["<S-Tab>"] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                        cmp.select_prev_item()
                      elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                      else
                        fallback()
                      end
                    end, { "i", "s" }),
                },
                sources = cmp.config.sources({
                        { name = "nvim_lsp", max_item_count = 3 },
                        { name = "nvim_lua" },
                        { name = "luasnip", max_item_count = 3}, -- For luasnip users.
                    }, {
                        { name = "buffer", max_item_count = 3 },
                        { name = "path" },
                    }),
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,

                },
            })
            cmp.setup.cmdline(":", {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = "path" },
                    }, {
                        { name = "cmdline" },
                    }),
                })
                    end
                }
}
