return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        -- NOTE: Make sure to install listed formatters with Mason
        require("conform").setup({
            formatters_by_ft = {
                -- stylua follows this style guide: https://roblox.github.io/lua-style-guide/
                lua = { "stylua" },
                python = { "ruff_format" },
                -- Conform will run the first available formatter
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                json = { "prettierd" },
            },
        })
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end,
}
