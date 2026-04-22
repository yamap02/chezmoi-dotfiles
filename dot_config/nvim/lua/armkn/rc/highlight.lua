local MY_GROUP = "armkn_highlight"
vim.api.nvim_create_augroup(MY_GROUP, { clear = true })

vim.fn.matchadd("ArmknTrailSpace", [[\s\+$]])

-- ColorScheme ロード後の highlight カスタマイズ
vim.api.nvim_create_autocmd("ColorScheme", {
    group = MY_GROUP,
    callback = function()
        vim.cmd([[hi ArmknTrailSpace guibg=red ctermbg=red]])

        -- render-markdown.nvim: 見出し背景色 (sonokai 配色に合わせた淡い背景)
        vim.cmd([[hi RenderMarkdownH1Bg guibg=#3d2b2b]])
        vim.cmd([[hi RenderMarkdownH2Bg guibg=#2b3d2b]])
        vim.cmd([[hi RenderMarkdownH3Bg guibg=#2b2b3d]])
        vim.cmd([[hi RenderMarkdownH4Bg guibg=#3d3d2b]])
        vim.cmd([[hi RenderMarkdownH5Bg guibg=#2b3d3d]])
        vim.cmd([[hi RenderMarkdownH6Bg guibg=#3d2b3d]])
    end,
})