return {
    { "MunifTanjim/nui.nvim", lazy = true },
    { "nvim-lua/plenary.nvim", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "LeafCage/yankround.vim", event = "VeryLazy" },
    { "folke/todo-comments.nvim", event = "BufReadPost", cmd = { "TodoLocList", "TodoQuickFix" } },
    { "kana/vim-smartchr", event = "InsertEnter" },
    -- vim-quickrun disabled (code runner, not needed)
    -- nvim-navic disabled (LSP breadcrumb, not needed without LSP)
}
