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
                    'markdown_inline', 'regex', 'templ'
                },
                sync_install = false,
                highlight = {
                    enable = true,
                },
                additional_vim_regex_highlighting = false,
            })
            vim.filetype.add({
                extension = {
                    templ = 'templ',
                }
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
    }
}
