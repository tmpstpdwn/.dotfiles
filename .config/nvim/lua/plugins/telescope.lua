require('telescope').setup{
  defaults = {
    preview = false,
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
    },
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120
      },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└"},
    color_devicons = true,
    mappings = {
      i = {
      }
    }
  },
  pickers = {
    find_files = {
      hidden = true,
      },
  },
  extensions = {
  }
}
