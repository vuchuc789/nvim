require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del
local gitsigns = require "gitsigns"

-- terminal
nomap("t", "<C-x>")
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap({ "n", "t" }, "<A-v>")
nomap({ "n", "t" }, "<A-h>")
nomap({ "n", "t" }, "<A-i>")

map({ "n", "v" }, "j", "gj")
map({ "n", "v" }, "k", "gk")

map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end)

map("n", "s", function()
  require("leap").leap { target_windows = { vim.api.nvim_get_current_win() } }
end)
map("n", "S", "<Plug>(leap-from-window)")
map({ "x", "o" }, "s", "<Plug>(leap-forward)")
map({ "x", "o" }, "S", "<Plug>(leap-backward)")

map("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "telescope grep string" })

-- Navigation
map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    gitsigns.nav_hunk "next"
  end
end, { desc = "jump to the next hunk" })

map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    gitsigns.nav_hunk "prev"
  end
end, { desc = "jump to the previous hunk" })

map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "stage hunk" })
map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "unstage hunk" })
map("v", "<leader>hs", function()
  gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "stage hunk" })
map("v", "<leader>hr", function()
  gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "unstage hunk" })
map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "stage buffer" })
map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "unstage buffer" })
map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "preview hunk" })
map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "preview hunk inline" })
map("n", "<leader>hb", function()
  gitsigns.blame_line { full = true }
end, { desc = "blame line" })
map("n", "<leader>hd", gitsigns.diffthis, { desc = "git diff" })
map("n", "<leader>hD", function()
  gitsigns.diffthis "~"
end, { desc = "git diff" })
map("n", "<leader>hQ", function()
  gitsigns.setqflist "all"
end, { desc = "list hunks" })
map("n", "<leader>hq", gitsigns.setqflist, { desc = "list hunks" })
map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "toggle line blame" })
map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "toggle deleted" })
map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "toggle diff" })

map({ "o", "x" }, "ih", gitsigns.select_hunk)
