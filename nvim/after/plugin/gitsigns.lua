-- Do not load up plugin when in diff mode.
if vim.opt.diff:get() then
  return
end

require("gitsigns").setup({
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
            gs.next_hunk()
            vim.schedule(function()
                feedkeys("zz", "n", false)
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Next git hunk" })

        map("n", "[g", function()
            if vim.wo.diff then
                return "[g"
            end
            gs.prev_hunk()
            vim.schedule(function()
                feedkeys("zz", "n", false)
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Previous git hunk" })

        -- Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "[H]unk [S]tage" })
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "[H]unk [R]eset" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
        end, { desc = "Blame line" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle current line blame" })
        map("n", "<leader>hd", gs.diffthis, { desc = "[H]unk [D]iff index" })
        map("n", "<leader>hD", function()
            gs.diffthis("~")
        end, { desc = "[H]unk [D]iff parent" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "[I]n [H]unk" })
    end,
})
