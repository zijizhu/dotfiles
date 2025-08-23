return {
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })
        end,
    },
    {

        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        config = function()
            require("todo-comments").setup()
            vim.keymap.set("n", "<leader>t", ":TodoFzfLua<enter>")
        end,
    },
}
