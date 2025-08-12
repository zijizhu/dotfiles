return {
  {
    'echasnovski/mini.statusline', version = false,
    config = function()
      require('mini.statusline').setup()
    end
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    config = function ()
      require('mini.surround').setup()
    end
  },
  {
    'echasnovski/mini.ai',
    version = false,
    config = function ()
      require('mini.ai').setup()
    end
  },
}
