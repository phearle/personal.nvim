local tokyonight = {
    'folke/tokyonight.nvim',
    lazy = true,
    priority = 1000,
    config = function()
        -- vim.cmd.colorscheme 'tokyonight-night'
    end,
}

local rosepine = {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme 'rose-pine'
    end
}

return {
    tokyonight,
    rosepine,
}
