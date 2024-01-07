return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                modules = {},
                ensure_installed = {
                    'bash', 'c', 'cpp', 'go', 'javascript', 'lua', 'markdown', 'markdown_inline', 'ocaml', 'odin',
                    'python', 'regex', 'rust', 'templ', 'typescript',
                },
                auto_install = true,
                sync_install = false,
                ignore_install = {},
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
        dependencies = {
            'nvim-treesitter/nvim-treesitter'
        },
    }
}
