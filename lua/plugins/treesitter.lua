return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'c', 'cpp', 'go', 'lua', 'python', 'rust',
                    'javascript', 'typescript', 'bash', 'markdown',
                    'markdown_inline', 'regex',
                },
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
    }
}
