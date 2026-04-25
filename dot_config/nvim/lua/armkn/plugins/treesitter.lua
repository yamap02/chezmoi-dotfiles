return {
    {
        "neovim-treesitter/nvim-treesitter",
        name = "nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        dependencies = {
            "neovim-treesitter/treesitter-parser-registry",
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                branch = "main",
                init = function()
                    vim.g.no_plugin_maps = true
                end,
                config = function()
                    local select_mode_config = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "<c-v>",
                    }

                    local has_new_textobjects, new_textobjects = pcall(require, "nvim-treesitter-textobjects")
                    if has_new_textobjects then
                        new_textobjects.setup({
                            select = {
                                lookahead = true,
                                selection_modes = select_mode_config,
                            },
                            move = {
                                set_jumps = true,
                            },
                        })
                    else
                        require("nvim-treesitter.configs").setup({
                            textobjects = {
                                select = {
                                    enable = true,
                                    lookahead = true,
                                    selection_modes = select_mode_config,
                                },
                                move = {
                                    enable = true,
                                    set_jumps = true,
                                },
                            },
                        })
                    end

                    local has_new_select, select = pcall(require, "nvim-treesitter-textobjects.select")
                    local has_new_move, move = pcall(require, "nvim-treesitter-textobjects.move")
                    if not has_new_select then
                        select = require("nvim-treesitter.textobjects.select")
                    end
                    if not has_new_move then
                        move = require("nvim-treesitter.textobjects.move")
                    end

                    vim.keymap.set({ "x", "o" }, "af", function()
                        select.select_textobject("@function.outer", "textobjects")
                    end, { desc = "function (outer)" })
                    vim.keymap.set({ "x", "o" }, "if", function()
                        select.select_textobject("@function.inner", "textobjects")
                    end, { desc = "function (inner)" })
                    vim.keymap.set({ "x", "o" }, "ac", function()
                        select.select_textobject("@class.outer", "textobjects")
                    end, { desc = "class (outer)" })
                    vim.keymap.set({ "x", "o" }, "ic", function()
                        select.select_textobject("@class.inner", "textobjects")
                    end, { desc = "class (inner)" })
                    vim.keymap.set({ "x", "o" }, "as", function()
                        select.select_textobject("@local.scope", "locals")
                    end, { desc = "scope" })

                    vim.keymap.set({ "n", "x", "o" }, "]f", function()
                        move.goto_next_start("@function.outer", "textobjects")
                    end, { desc = "Next function start" })
                    vim.keymap.set({ "n", "x", "o" }, "]c", function()
                        move.goto_next_start("@class.outer", "textobjects")
                    end, { desc = "Next class start" })
                    vim.keymap.set({ "n", "x", "o" }, "[f", function()
                        move.goto_previous_start("@function.outer", "textobjects")
                    end, { desc = "Prev function start" })
                    vim.keymap.set({ "n", "x", "o" }, "[c", function()
                        move.goto_previous_start("@class.outer", "textobjects")
                    end, { desc = "Prev class start" })
                end,
            },
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                opts = { enable_autocmd = false },
            },
            {
                "andymass/vim-matchup",
                init = function()
                    vim.g.matchup_matchparen_offscreen = { method = "popup" }
                    -- Neovim 0.12.0 の treesitter API 変更との非互換のため treesitter エンジンを無効化
                    vim.g.matchup_matchparen_deferred = 1
                    vim.g.matchup_treesitter_enable = 0
                end,
            },
        },
        config = function()
            local parsers = {
                "bash",
                "go",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "vim",
                "yaml",
            }

            local filetypes = {
                "go",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "python",
                "sh",
                "vim",
                "yaml",
                "zsh",
            }

            local has_new_core, core = pcall(require, "nvim-treesitter")
            if has_new_core and type(core.setup) == "function" then
                core.setup({
                    install_dir = vim.fn.stdpath("data") .. "/site",
                })
                vim.treesitter.language.register("bash", { "sh", "zsh" })

                if vim.fn.executable("tree-sitter") == 1 then
                    local ok, err = pcall(core.install, parsers)
                    if not ok then
                        vim.notify(err, vim.log.levels.WARN)
                    end
                else
                    vim.schedule(function()
                        vim.notify_once(
                            "tree-sitter CLI 未導入のため parser 自動 install をスキップ: brew install tree-sitter",
                            vim.log.levels.WARN
                        )
                    end)
                end

                vim.api.nvim_create_autocmd("FileType", {
                    group = vim.api.nvim_create_augroup("armkn_treesitter", { clear = true }),
                    pattern = filetypes,
                    callback = function(args)
                        local ok_start = pcall(vim.treesitter.start, args.buf)
                        if not ok_start then
                            return
                        end
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end,
                })
                return
            end

            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                indent = { enable = true },
                matchup = { enable = false },
                ensure_installed = parsers,
                incremental_selection = {
                    enable = false,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = "<nop>",
                        node_decremental = "<bs>",
                    },
                },
            })
        end,
    },
}
