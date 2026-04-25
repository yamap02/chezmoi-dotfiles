return {
    {
        "echasnovski/mini.ai",
        version = false,
        event = "ModeChanged",
        opts = {
            custom_textobjects = {
                ["s"] = { "%f[%w]%w+", "^().*()$" }, -- like `w`, except underbar
            },
        },
        config = function(_, opts)
            require("mini.ai").setup(opts)
        end,
    },
}
