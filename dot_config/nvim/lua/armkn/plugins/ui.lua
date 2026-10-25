return {
    -- dressing.nvim (アーカイブ済み) と nvim-notify を snacks.nvim に集約
    -- 見た目・キー操作は旧プラグインの既定に寄せている
    {
        "folke/snacks.nvim",
        lazy = false,
        priority = 1000,
        keys = {
            {
                "<leader>un",
                function()
                    Snacks.notifier.hide()
                end,
                desc = "Delete all Notifications",
            },
        },
        init = function()
            vim.api.nvim_create_user_command("Notifications", function()
                Snacks.notifier.show_history()
            end, { desc = "Notification History" })
        end,
        opts = {
            -- vim.ui.input: dressing と同じくカーソル直下に小さく出す
            input = {
                enabled = true,
                icon_pos = false,
            },
            -- vim.ui.select: dressing の builtin と同じく一覧にフォーカスして開く
            -- (j/k で移動・<CR> で決定・<Esc> で閉じる。/ で絞り込み)
            picker = {
                enabled = true,
                ui_select = true,
                sources = {
                    select = { focus = "list" },
                },
            },
            notifier = {
                enabled = true,
                -- WARN 以下はポップアップせず履歴のみ（:Notifications で確認）
                level = vim.log.levels.ERROR,
                -- timeout = 3000,
                timeout = 1,
                style = "fancy", -- nvim-notify の既定に近い表示
                width = { min = 40, max = 0.45 },
                height = { min = 1, max = 0.45 },
            },
            styles = {
                input = {
                    relative = "cursor",
                    row = 1,
                    col = 0,
                    width = 40,
                    border = "rounded",
                    title_pos = "left",
                    keys = {
                        -- dressing と同じく insert モードの <C-c> で閉じる
                        i_ctrl_c = { "<c-c>", "cancel", mode = "i" },
                    },
                },
            },
        },
    },
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     event = { "BufReadPost", "BufNewFile" },
    --     opts = function()
    --         local colors = require("tokyonight.colors").setup()
    --         local util = require("tokyonight.util")
    --         -- local colors = require("sonokai.colors").setup()
    --         -- local util = require("sonokai.util")
    --
    --         vim.cmd("hi IndentBlanklineIndent1 gui=nocombine guibg=" .. util.darken(colors.bg_dark, -2))
    --         vim.cmd("hi IndentBlanklineIndent2 gui=nocombine guibg=" .. util.darken(colors.bg_dark, 0.5))
    --         return {
    --             char = "",
    --             filetype_exclude = { "help", "alpha", "dashboard", "Trouble", "lazy" },
    --             show_trailing_blankline_indent = false,
    --             show_current_context = false,
    --             char_highlight_list = {
    --                 "IndentBlanklineIndent1",
    --                 "IndentBlanklineIndent2",
    --             },
    --             space_char_highlight_list = {
    --                 "IndentBlanklineIndent1",
    --                 "IndentBlanklineIndent2",
    --             },
    --         }
    --     end,
    -- },
}
