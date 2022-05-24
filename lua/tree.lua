vim.g.nvim_tree_add_trailing = 1

require'nvim-tree'.setup {
  git = {
    ignore = false,
  },
  update_focused_file = {
    enable = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
}
