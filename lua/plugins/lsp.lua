return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "tsserver", "pyright", "eslint", "sqls" }
            })
            local on_attach = function(client, bufnr)
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
                -- vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition)
                -- vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)
                -- vim.keymap.set('n', 'gr', vim.lsp.buf.references)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
                vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, { desc = "Format current buffer with LSP" })

            end
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            require"lspconfig".lua_ls.setup{
                on_attach = on_attach,
                capabilities = capabilities,
            }
            require"lspconfig".tsserver.setup{
                on_attach = on_attach,
                capabilities = capabilities,
            }
            require"lspconfig".pyright.setup{
                on_attach = on_attach,
                capabilities = capabilities,
            }
            require"lspconfig".sqls.setup{
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end

    }
}
