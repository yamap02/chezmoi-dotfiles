-- nvim-cmp, LuaSnip disabled (no longer needed for coding)
return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function(_, opts)
            local autopairs = require("nvim-autopairs")
            autopairs.setup(opts)
        end,
    },
}
