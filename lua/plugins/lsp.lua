-- much of this is taken from kickstart.nvim

local servers = {
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
    pyright = {
        pyright = {
            autoImportCompletion = true,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'workspace',
                exclude = { '.venv*' },
            }
        }
    },
    ols = {
    }
}

local on_attach = function(_, bufnr)
    -- Helper for setting key maps.
    local nmap = function(keys, func, desc)
        -- if desc then
        --     desc = 'LSP: ' .. desc
        -- end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    require('which-key').register({
        ['<leader>l'] = { name = 'LSP', _ = 'which_key_ignore' },
        ['<leader>ls'] = { name = 'Symbols', _ = 'which_key_ignore' },
    })
    nmap('<leader>lR', vim.lsp.buf.rename, 'Rename')
    nmap('<leader>la', vim.lsp.buf.code_action, 'Code Action')

    nmap('<leader>ld', require('telescope.builtin').lsp_definitions, 'Goto Definition')
    nmap('<leader>lr', require('telescope.builtin').lsp_references, 'Goto References')
    nmap('<leader>lI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
    nmap('<leader>lD', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
    nmap('<leader>lsd', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
    nmap('<leader>lsw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    -- nmap('<leader>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    local format = function(_)
        vim.lsp.buf.format()
    end
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', format, { desc = 'Format current buffer with LSP' })
end

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            -- { 'j-hui/fidget.nvim',       opts = {} },
            'folke/neodev.nvim'
        },
        config = function()
            require('neodev').setup()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            local mason_lspconfig = require('mason-lspconfig')
            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(servers)
            })
            mason_lspconfig.setup_handlers({
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    })
                end,
            })
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'rafamadriz/friendly-snippets',
            'onsails/lspkind.nvim',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            require('luasnip.loaders.from_vscode').lazy_load()
            luasnip.config.setup()
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'codeium' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-Space>'] = cmp.mapping.complete({}),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                }),
                formatting = {
                    format = require('lspkind').cmp_format({
                        mode = 'symbol',
                        maxwidth = 50,
                        ellipsis_char = '...',
                        symbol_map = { Codeium = "󱚝" },
                    })
                },
            })
        end,
    },
}
