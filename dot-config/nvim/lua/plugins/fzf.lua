return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    config = function()
        require("fzf-lua").setup({
            winopts = {
                backdrop = 100,
                preview = {
                    layout = "vertical",
                },
            },
        })
        vim.keymap.set("n", "<leader>f", function()
            require("fzf-lua").files()
        end, {})
        vim.keymap.set("n", "<leader>d", function()
            require("fzf-lua").files({
                cmd = "fd --type d .", -- Use 'fd' to find only directories
                -- cwd = "~", -- Start search from home directory or any desired path
                prompt = "Search Directories: ",
            })
        end, {})
        vim.keymap.set("n", "<leader>g", function()
            require("fzf-lua").live_grep()
        end, {})
        vim.keymap.set("n", "<leader>b", function()
            require("fzf-lua").buffers()
        end, {})
        vim.keymap.set("n", "<leader>s", function()
            require("fzf-lua").grep_cword()
        end, {})
    end,
}
