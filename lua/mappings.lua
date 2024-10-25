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
