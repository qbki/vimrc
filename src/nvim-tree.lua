-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = false,
    icons = {
      show = {
        file = false,
        folder = false,
      },
      glyphs = {
        symlink = "☞",
        modified = "●",
        folder = {
          arrow_closed = "⮞",
          arrow_open = "⮟",
          default = "🗀",
          open = "🗁",
          empty = "⮊",
          empty_open = "⮋",
          symlink = "☞",
          symlink_open = "☟",
        },
      },
    },
  },
  filters = {
    dotfiles = true,
  },
  git = {
    enable = false,
    show_on_dirs = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    icons = {
      hint = "?",
      info = "i",
      warning = "!",
      error = "!",
    },
  },
})
