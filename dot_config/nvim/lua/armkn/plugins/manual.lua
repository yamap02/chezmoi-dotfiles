return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.add({
                { "g",              group = "goto",               mode = { "n", "v" } },
                { "s",              group = "surround",           mode = { "n", "v" } },
                { "]",              group = "next",               mode = { "n", "v" } },
                { "[",              group = "prev",               mode = { "n", "v" } },
                { "<leader><tab>",  group = "tabs",               mode = { "n", "v" } },
                { "<leader>b",      group = "buffer",             mode = { "n", "v" } },
                { "<leader>c",      group = "code",               mode = { "n", "v" } },
                { "<leader>f",      group = "file/find",          mode = { "n", "v" } },
                { "<leader>g",      group = "git",                mode = { "n", "v" } },
                { "<leader>gh",     group = "hunks",              mode = { "n", "v" } },
                { "<leader>q",      group = "quit/session",       mode = { "n", "v" } },
                { "<leader>s",      group = "search",             mode = { "n", "v" } },
                { "<leader>u",      group = "ui",                 mode = { "n", "v" } },
                { "<leader>w",      group = "windows",            mode = { "n", "v" } },
                { "<leader>x",      group = "diagnostics/quickfix", mode = { "n", "v" } },
            })
        end,
    },
}