return {
    'mbbill/undotree',
    keys = function()
        require('which-key').add({
            { '<leader>u',  group = 'Undotree' },
            { '<leader>u_', hidden = true },
        })
        return {
            { '<leader>ut', '<cmd>UndotreeToggle<cr>', desc = 'Undotree Toggle' },
        }
    end
}
