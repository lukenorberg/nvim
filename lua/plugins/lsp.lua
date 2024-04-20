return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup({
                opts = {
                    ensure_installed = {
                        "eslint-lsp"
                    }
                }
            })
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "tsserver", "pyright", "sqls", "tailwindcss", "emmet_ls" }
            })
            local on_attach = function(client, bufnr)
                if client.config.flags then
                    client.config.flags.allow_incremental_sync = true
                end
                client.resolved_capabilities.document_formatting = false
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
                -- vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition)
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)
                -- vim.keymap.set('n', 'gr', vim.lsp.buf.references)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
                vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, { desc = "Format current buffer with LSP" })

            end
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require"lspconfig".lua_ls.setup{
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                      runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                      },
                      diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {
                          'vim',
                          'require'
                        },
                      },
                      workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                      },
                      -- Do not send telemetry data containing a randomized but unique identifier
                      telemetry = {
                        enable = false,
                      },
                    },
                  },
            }
            require"lspconfig".tsserver.setup{
                on_attach = on_attach,
                capabilities = capabilities,
                init_options = {
                    preferences = {
                        disableSuggestions = true,
                    }
                }
            }
            require"lspconfig".pyright.setup{
                on_attach = on_attach,
                capabilities = capabilities,
            }
            require"lspconfig".sqls.setup{
                on_attach = on_attach,
                capabilities = capabilities,
            }
            require"lspconfig".tailwindcss.setup{
                on_attach = on_attach,
                capabilities = capabilities,
            }
            require"lspconfig".emmet_ls.setup{
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end
    }
}
