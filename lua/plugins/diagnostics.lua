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
        local lsp_references = function()
            trouble.toggle('lsp_references')
        end
        require('which-key').register({
            ['<leader>x'] = { name = 'Trouble', _ = 'which_key_ignore' },
        })
        return {
            { '<leader>xx', toggle,         desc = 'Trouble' },
            { '<leader>xr', lsp_references, desc = 'LSP References' },
        }
    end,
    config = function()
        require('trouble').setup()
    end
}
