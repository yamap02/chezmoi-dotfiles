return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            return {
                options = {
                    theme = "moonfly",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "dashboard", "alpha" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {},
                    lualine_c = {
                        { "filename", path = 1 },
                    },
                    lualine_x = {
                        "filetype",
                    },
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = { { "filename", path = 1 } },
                    lualine_c = {},
                },
                extensions = { "lazy" },
            }
        end,
    },
}
