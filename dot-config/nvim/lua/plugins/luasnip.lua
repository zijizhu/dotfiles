return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
  end
}
