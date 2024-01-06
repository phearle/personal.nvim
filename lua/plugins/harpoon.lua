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
            local selector = function(number)
                return function()
                    local harpoon = require('harpoon')
                    harpoon:list():select(number)
                end
            end
            require('which-key').register({
                ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
            })
            return {
                { '<leader>ho', toggle_quick_menu, desc = 'Open Quick Menu' },
                { '<leader>ha', append_file,       desc = 'Append File' },
                { '<leader>hh', selector(1),       desc = 'Select Item 1' },
                { '<leader>hj', selector(2),       desc = 'Select Item 2' },
                { '<leader>hk', selector(3),       desc = 'Select Item 3' },
                { '<leader>hl', selector(4),       desc = 'Select Item 4' },
            }
        end,
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup()
        end,
    }
}
