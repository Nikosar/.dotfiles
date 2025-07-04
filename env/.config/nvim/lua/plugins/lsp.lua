return {
    -- {
    --   "williamboman/mason.nvim",
    --   config = function()
    --     require("mason").setup()
    --   end
    -- },
    -- {
    --   "williamboman/mason-lspconfig.nvim",
    --   config = function()
    --     require("mason-lspconfig").setup({
    --       ensure_installed = {"lua_ls"}
    --     })
    --   end
    -- },
    -- {
    --   "neovim/nvim-lspconfig",
    --   config = function()
    --     local lspconfig = require("lspconfig")
    --
    --     lspconfig.lua_ls.setup({})
    --   end
    -- }

    {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {'neovim/nvim-lspconfig'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/nvim-cmp'},
        {'L3MON4D3/LuaSnip'},
        {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x',
            config = function()
                local lsp_zero = require('lsp-zero')
                lsp_zero.extend_lspconfig()

                lsp_zero.on_attach(function(client, bufnr)
                    local opts = {buffer = bufnr, remap = false}

                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)                end)


                require("mason").setup({})
                require("mason-lspconfig").setup({
                    ensure_installed = {"lua_ls", "terraformls"},
                    handlers = {
                        lsp_zero.default_setup,
                        lua_ls = function ()
                            local lspconfig = require("lspconfig")
                            lspconfig.lua_ls.setup({})
                        end
                    }
                })
            end

        }
    }
}
