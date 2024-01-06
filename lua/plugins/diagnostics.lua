return {
    'folke/trouble.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    keys = function()
        local trouble = require('trouble')
        local toggle = function()
            trouble.toggle()
        end
        local open = function()
            trouble.open()
        end
        local lsp_references = function()
            trouble.toggle('lsp_references')
        end
        local workspace_diag = function()
            trouble.toggle('workspace_diagnostics')
        end
        local document_diag = function()
            trouble.toggle('document_diagnostics')
        end
        local quickfix = function()
            trouble.toggle('quickfix')
        end
        local loclist = function()
            trouble.toggle('loclist')
        end
        local next = function()
            trouble.next({ skip_groups = true, jump = true })
        end
        local prev = function()
            trouble.previous({ skip_groups = true, jump = true })
        end
        require('which-key').register({
            ['<leader>x'] = { name = 'Trouble', _ = 'which_key_ignore' },
        })
        return {
            { '<leader>xx', toggle,         desc = 'Toggle' },
            { '<leader>xw', workspace_diag, desc = 'Toggle Workspace Diagnostics' },
            { '<leader>xd', document_diag,  desc = 'Document Diagnostics' },
            { '<leader>xq', quickfix,       desc = 'Quickfix' },
            { '<leader>xl', loclist,        desc = 'Loclist' },
            { '<leader>xo', open,           desc = 'Open' },
            { '<leader>xn', next,           desc = 'Next Item' },
            { '<leader>xp', prev,           desc = 'Previous Item' },
            { '<leader>xr', lsp_references, desc = 'LSP References' },
        }
    end,

    config = function()
        require('trouble').setup()
    end
}
