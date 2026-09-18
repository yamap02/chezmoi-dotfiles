return {
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown", "md" },
        build = "cd app && npm install",
        cmd = {
            "MarkdownPreview",
            "MarkdownPreviewStop",
            "MarkdownPreviewToggle",
        },
        init = function()
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_command_for_global = 0
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_browser = ""
            vim.g.mkdp_theme = "dark"
        end,
        keys = {
            {
                "<leader>mp",
                "<cmd>MarkdownPreviewToggle<cr>",
                ft = { "markdown", "md" },
                desc = "Markdown HTML Preview",
            },
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        enabled = false,
        dependencies = {
            "neovim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ft = { "markdown", "md" },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            anti_conceal = {
                enabled = false,
            },
            -- 見出し: レベルごとにアイコンと背景色を付ける
            heading = {
                enabled = true,
                sign = true,
                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
                -- 見出し行全体を背景色でハイライト
                width = "full",
                backgrounds = {
                    "RenderMarkdownH1Bg",
                    "RenderMarkdownH2Bg",
                    "RenderMarkdownH3Bg",
                    "RenderMarkdownH4Bg",
                    "RenderMarkdownH5Bg",
                    "RenderMarkdownH6Bg",
                },
            },
            -- コードブロック: 背景色 + 言語アイコン表示
            code = {
                enabled = true,
                sign = true,
                style = "full",  -- "full" = 背景色 + 枠線
                width = "full",
                border = "thin",
            },
            -- 箇条書きアイコン
            bullet = {
                enabled = true,
                icons = { "●", "○", "◆", "◇" },
            },
            -- チェックボックス
            checkbox = {
                enabled = true,
                unchecked = { icon = "󰄱 " },
                checked = { icon = "󰱒 " },
            },
            -- 水平線
            dash = { enabled = true },
            -- テーブル
            pipe_table = { enabled = true },
            -- インラインコード
            inline_highlight = { enabled = true },
            -- リンク
            link = {
                enabled = true,
                image = "󰥶 ",
                hyperlink = "󰌹 ",
            },
        },
    },
}
