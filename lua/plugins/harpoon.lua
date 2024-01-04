return {
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'folke/which-key.nvim',
        },
        keys = function()
            local toggle_quick_menu = function()
                local harpoon = require('harpoon')
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end
            local append_file = function()
                local harpoon = require('harpoon')
                harpoon:list():append()
            end
            require('which-key').register({
                ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
            })
            return {
                { '<leader>hq', toggle_quick_menu, desc = '[Q]uick Menu' },
                { '<leader>ha', append_file, desc = '[A]ppend File' },
            }
        end,
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup()
        end,
    }
}
