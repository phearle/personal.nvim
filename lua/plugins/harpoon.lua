return {
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'folke/which-key.nvim',
        },
        keys = function()
            -- Toggles the Harpoon quick menu
            local toggle_quick_menu = function()
                local harpoon = require('harpoon')
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end
            -- Appends a file to Harpoon list
            local append_file = function()
                local harpoon = require('harpoon')
                harpoon:list():append()
            end
            -- Returns a function that selects the list item at the given slot number.
            local selector = function(slot_number)
                -- Jumps to an item
                return function()
                    local harpoon = require('harpoon')
                    harpoon:list():select(slot_number)
                end
            end
            require('which-key').add({
                { '<leader>h',  group = 'Harpoon' },
                { '<leader>h_', hidden = true },
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
        opts = {},
    }
}
