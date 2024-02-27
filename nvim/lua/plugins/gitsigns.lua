-- Do not load up plugin when in diff mode.
if vim.opt.diff:get() then
    return {}
end

return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
        attach_to_untracked = true,
        current_line_blame_opts = {
            delay = 300,
        },
        _extmark_signs = false,
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local feedkeys = vim.api.nvim_feedkeys

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map("n", "]g", function()
                if vim.wo.diff then
                    return "]g"
                end
                vim.schedule(function()
                    gs.next_hunk()
                    feedkeys("zz", "n", false)
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Next git hunk" })

            map("n", "[g", function()
                if vim.wo.diff then
                    return "[g"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                    feedkeys("zz", "n", false)
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Previous git hunk" })

            -- Actions
            -- stylua: ignore start
            map("n", "<leader>hs", gs.stage_hunk,      { desc = "[H]unk [S]tage" })
            map("n", "<leader>hr", gs.reset_hunk,      { desc = "[H]unk [R]eset" })
            map("v", "<leader>hs", function()
                gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")}
            end,                                       { desc = "[H]unk [S]tage" })
            map("v", "<leader>hr", function()
                gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")}
            end,                                       { desc = "[H]unk [R]eset" })
            map("n", "<leader>hS", gs.stage_buffer,    { desc = "[H]unk [S]tage buffer" })
            map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[H]unk [U]ndo stage" })
            map("n", "<leader>hU", function()
                os.execute("git restore --staged " .. vim.fn.expand("%"))
                gs.refresh()
            end,                                       { desc = "[H]unk [U]ndo stage buffer" })
            map("n", "<leader>hR", gs.reset_buffer,    { desc = "[H]unk [R]eset buffer" })
            map("n", "<leader>hp", gs.preview_hunk,    { desc = "[H]unk [P]review" })
            map("n", "<leader>hb", function()
                gs.blame_line({ full = true, ignore_whitespace = true })
            end,                                       { desc = "[H]unk [B]lame line" })
            map("n", "<leader>hd", gs.diffthis,        { desc = "[H]unk [D]iff index" })
            map("n", "<leader>hD", function()
                gs.diffthis("~")
            end,                                       { desc = "[H]unk [D]iff parent" })
            map("n", "<leader>id", gs.toggle_deleted,  { desc = "[I]nspect [D]eleted" })
            -- stylua: ignore end

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "git hunk" })
        end,
    },
}
