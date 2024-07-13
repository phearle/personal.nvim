return {
    {
        'S1M0N38/love2d.nvim',
        cmd = "LoveRun",
        opts = {},
        keys = {
            { "<leader>v",  ft = "lua",          desc = "LOVE" },
            { "<leader>vv", "<cmd>LoveRun<cr>",  ft = "lua",   desc = "Run LOVE" },
            { "<leader>vs", "<cmd>LoveStop<cr>", ft = "lua",   desc = "Stop LOVE" },
        },
    },
}
