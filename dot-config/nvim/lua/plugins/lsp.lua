return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- Language Servers
                    "lua_ls",
                    "bashls",
                    "ruff",
                    "clangd",
                    "dockerls",
                    "ltex",
                    "tinymist",
                    "marksman",
                    "rust_analyzer",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- [[ Language specific settings ]]
            -- Python
            vim.lsp.config("ruff", {
                init_options = {
                    settings = {
                        -- Server settings should go here
                    },
                },
            })
            -- C/C++
            -- NOTE: The `--enable-config` flag will work with clangd-21
            vim.lsp.enable("clangd", {
                cmd = { "clangd", "--enable-config" },
            })

            -- Bash
            vim.lsp.enable("bashls")

            -- PostgreSQL
            vim.lsp.enable("postgres_lsp")

            -- LTEX
            vim.lsp.enable("ltex")

            -- Marksman
            vim.lsp.enable("marksman")

            -- typst
            vim.lsp.enable("tinymist")

            -- docker
            vim.lsp.config("dockerls", {
                settings = {
                    docker = {
                        languageserver = {
                            formatter = {
                                ignoreMultilineInstructions = true,
                            },
                        },
                    },
                },
            })

            -- Rust
            vim.lsp.config("rust_analyzer", {
                settings = {
                    ["rust-analyzer"] = {
                        diagnostics = {
                            enable = false,
                        },
                    },
                },
            })

            -- Lua
            vim.lsp.config("lua_ls", {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath("config")
                            and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most
                            -- likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                            -- Tell the language server how to find Lua modules same way as Neovim
                            -- (see `:h lua-module-load`)
                            path = {
                                "lua/?.lua",
                                "lua/?/init.lua",
                            },
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                -- Depending on the usage, you might want to add additional paths
                                -- here.
                                -- '${3rd}/luv/library'
                                -- '${3rd}/busted/library'
                            },
                            -- Or pull in all of 'runtimepath'.
                            -- NOTE: this is a lot slower and will cause issues when working on
                            -- your own configuration.
                            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                            -- library = {
                            --   vim.api.nvim_get_runtime_file('', true),
                            -- }
                        },
                    })
                end,
                settings = {
                    Lua = {},
                },
            })
            vim.lsp.enable("ts_go_ls")
        end,
    },
}
