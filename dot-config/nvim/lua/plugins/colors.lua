-- Colorscheme Plugins
return {
    {
        "rebelot/kanagawa.nvim",
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme catppuccin-mocha")
        end,
    },
    {
        "vague2k/vague.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other plugins
        config = function()
            -- NOTE: you do not need to call setup if you don't want to.
            require("vague").setup({})
            vim.cmd("colorscheme vague")
        end,
    },
}
