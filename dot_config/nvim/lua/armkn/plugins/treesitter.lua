return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                opts = { enable_autocmd = false },
            },
            "m-demare/hlargs.nvim",
            {
                "windwp/nvim-ts-autotag",
                config = function()
                    require("nvim-ts-autotag").setup()
                end,
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
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" },
        },
        ---@type TSConfig
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            matchup = { enable = false }, -- Neovim 0.12.0 treesitter API 変更との非互換のため無効化
            ensure_installed = {
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
            },
            incremental_selection = {
                enable = false,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<nop>",
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = { query = "@function.outer", desc = "function (outer)" },
                        ["if"] = { query = "@function.inner", desc = "function (inner)" },
                        ["ac"] = { query = "@class.outer", desc = "class (outer)" },
                        ["ic"] = { query = "@class.inner", desc = "class (inner)" },
                        ["as"] = { query = "@scope", query_group = "locals", desc = "scope" },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V", -- linewise
                        ["@class.outer"] = "<c-v>", -- blockwise
                    },
                },
                swap = {
                    enable = false,
                    swap_next = { [",al"] = "@parameter.inner" },
                    swap_previous = { [",ah"] = "@parameter.inner" },
                },
                move = {
                    enable = false,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]f"] = { query = "@function.outer", desc = "Next function start" },
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                    },
                    goto_previous_start = {
                        ["[f"] = { query = "@function.outer", desc = "Prev function start" },
                        ["[c"] = { query = "@class.outer", desc = "Prev class start" },
                    },
                },
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
