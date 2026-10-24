return {
    {
        "NvChad/nvim-colorizer.lua",
        ft = { "markdown", "md" },
        opts = {
            filetypes = { "markdown", "md" },
            user_default_options = {
                mode = "background",
                tailwind = true,
                css = true,
                css_fn = true,
                names = false,
                RGB = true,
                RRGGBB = true,
                RRGGBBAA = true,
                AARRGGBB = true,
                always_update = false,
            },
        },
    },
    -- ブラウザプレビュー: Node 不要の pure Lua 実装 (KaTeX / Mermaid 対応)
    {
        "brianhuster/live-preview.nvim",
        cmd = "LivePreview",
        init = function()
            -- :Preview だけで起動/停止をトグルする
            vim.api.nvim_create_user_command("Preview", function()
                if require("livepreview").is_running() then
                    vim.cmd("LivePreview close")
                else
                    vim.cmd("LivePreview start")
                end
            end, { desc = "Markdown HTML Preview Toggle" })
        end,
        config = function()
            require("livepreview.config").set({
                port = 5500,
                -- macOS ではプレビューを Brave で開く (他OSは既定ブラウザ)
                browser = vim.fn.has("mac") == 1 and "open -a 'Brave Browser'" or "default",
                -- ファイルのあるディレクトリをルートにする (相対パスの画像を解決するため)
                dynamic_root = true,
                sync_scroll = true,
            })

            -- 同梱の github-markdown.css は本文幅を 980px に固定して中央寄せするため、
            -- 生成 HTML に上書き CSS を差し込んでウィンドウ幅いっぱいに広げる
            -- (カスタム CSS の設定項目が無いので md2html をラップする)
            local template = require("livepreview.template")
            local md2html = template.md2html
            template.md2html = function(md)
                local style = "<style>.markdown-body{max-width:none;margin:16px 32px}</style>"
                return (md2html(md):gsub("</head>", function()
                    return style .. "</head>"
                end, 1))
            end
        end,
        keys = {
            {
                "<leader>mp",
                "<cmd>Preview<cr>",
                ft = { "markdown", "md" },
                desc = "Markdown HTML Preview",
            },
        },
    },
    -- バッファ内レンダリング
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "neovim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ft = { "markdown", "md" },
        keys = {
            {
                "<leader>mr",
                "<cmd>RenderMarkdown toggle<cr>",
                ft = { "markdown", "md" },
                desc = "Markdown Render Toggle",
            },
        },
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
