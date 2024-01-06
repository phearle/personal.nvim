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
            { '<leader>xx', toggle,         desc = 'Trouble Toggle' },
            { '<leader>xw', workspace_diag, desc = 'Trouble Toggle Workspace Diagnostics' },
            { '<leader>xd', document_diag,  desc = 'TroubleToggle Document Diagnostics' },
            { '<leader>xq', quickfix,       desc = 'TroubleToggle Quickfix' },
            { '<leader>xl', loclist,        desc = 'TroubleToggle Loclist' },
            { '<leader>xo', open,           desc = 'Trouble Open' },
            { '<leader>xn', next,           desc = 'Trouble Next Item' },
            { '<leader>xp', prev,           desc = 'Trouble Previous Item' },
            { '<leader>xr', lsp_references, desc = 'Trouble LSP References' },
        }
    end,

    config = function()
        require('trouble').setup()
    end
}
