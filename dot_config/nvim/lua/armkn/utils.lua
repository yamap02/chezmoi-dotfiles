local M = {}

M.root_patterns = { ".git", "Makefile" }

-- returns the root directory based on:
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
    ---@type string?
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.uv.fs_realpath(path) or nil
    path = path and vim.fs.dirname(path) or vim.uv.cwd()
    ---@type string?
    local root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.uv.cwd()
    ---@cast root string
    return root
end

---@param ft string|table<string>
---@param callback function
function M.autocmd_filetype(ft, callback)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = ft,
        callback = callback,
    })
end

return M
