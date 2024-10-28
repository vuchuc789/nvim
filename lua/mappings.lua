require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "v" }, "j", "gj")
map({ "n", "v" }, "k", "gk")

map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

map("v", "<", "<gv")
map("v", ">", ">gv")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end)

map("n", "s", function()
  require("leap").leap { target_windows = { vim.api.nvim_get_current_win() } }
end)
map("n", "S", "<Plug>(leap-from-window)")
map({ "x", "o" }, "s", "<Plug>(leap-forward)")
map({ "x", "o" }, "S", "<Plug>(leap-backward)")

local pantran_opts = { noremap = true, silent = true, expr = true }
map("n", "<leader>tr", require("pantran").motion_translate, pantran_opts)
map("n", "<leader>trr", function()
  return require("pantran").motion_translate() .. "_"
end, pantran_opts)
map("x", "<leader>tr", require("pantran").motion_translate, pantran_opts)
