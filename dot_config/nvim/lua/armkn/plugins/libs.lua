return {
    { "MunifTanjim/nui.nvim", lazy = true },
    { "nvim-lua/plenary.nvim", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    -- yankround.vim の後継。p/P/gp/gP のマッピングは rc/keymaps.lua
    {
        "gbprod/yanky.nvim",
        event = "VeryLazy",
        opts = {
            ring = {
                -- ヤンクで "1-"9 をずらさない (素の Vim と同じ挙動のまま)
                sync_with_numbered_registers = false,
            },
            highlight = {
                -- ヤンク時は rc/autocmd.lua の TextYankPost でハイライト済み
                on_yank = false,
                -- yankround と同じくペースト範囲はハイライトしない
                on_put = false,
            },
        },
    },
    { "folke/todo-comments.nvim", event = "BufReadPost", cmd = { "TodoLocList", "TodoQuickFix" } },
    { "kana/vim-smartchr", event = "InsertEnter" },
    -- vim-quickrun disabled (code runner, not needed)
    -- nvim-navic disabled (LSP breadcrumb, not needed without LSP)
}
