return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
      require("ibl").setup({
        enabled = false
      })
      vim.keymap.set('n', '<leader>i', ':IBLToggle<enter>', {})
    end
}
