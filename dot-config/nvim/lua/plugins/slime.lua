return {
  "jpalardy/vim-slime",
  config = function()
    vim.g.slime_target = "wezterm"
    vim.g.slime_cell_delimiter = "# %%"
    -- vim.g.slime_bracketed_paste = 1
    vim.g.slime_default_config = { pane_direction = "right" }
    vim.g.slime_python_ipython = 1
  end,
}
