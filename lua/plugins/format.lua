return {
    {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = function()
            local format = function()
                require('conform').format({ async = true, lsp_fallback = true })
            end
            return {
                { '<leader>f', format, desc = 'Format', mode = "" },
            }
        end,
        opts = {
            formatters_by_ft = {
                lua = { "luaformatter" },
                go = { "golines", "gofumpt" },
                sh = { "beautysh" },
                zsh = { "beautysh" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        },
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    }
}
