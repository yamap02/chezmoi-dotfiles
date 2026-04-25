return {
    { "MunifTanjim/nui.nvim", lazy = true },
    { "nvim-lua/plenary.nvim", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "LeafCage/yankround.vim", event = "VeryLazy" },
    {
        "mg979/vim-visual-multi",
        keys = {
            { "<C-n>", mode = { "n", "x" } },
            { "<C-Down>", mode = { "n", "x" } },
            { "<C-Up>", mode = { "n", "x" } },
        },
    },
    { "folke/todo-comments.nvim", event = "BufReadPost", cmd = { "TodoTelescope", "TodoLocList", "TodoQuickFix" } },
    { "kana/vim-smartchr", event = "InsertEnter" },
    -- vim-quickrun disabled (code runner, not needed)
    -- nvim-navic disabled (LSP breadcrumb, not needed without LSP)
}
