
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
        end

        require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        }):find()
    end

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-j>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-k>", function() harpoon:list():next() end)

    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      desc     = "Source ftplugin/$1.lua to override Issue #626",
      group    = vim.api.nvim_create_augroup("Harpoon_Optlocal", { clear = true }),
      callback = function()
        local ft = vim.bo.filetype
        vim.cmd("silent! source ~/.config/nvim/after/ftplugin/" .. ft .. ".lua")
      end,
    })
  end
}
