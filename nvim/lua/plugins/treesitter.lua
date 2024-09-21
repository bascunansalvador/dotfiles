return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
	local configs = require("nvim-treesitter.configs")
	configs.setup({
		  ensure_installed = {
			  "c", "cpp", "java", "go", "kotlin",
			  "haskell",  "lua", "vim", "vimdoc", "query",
			  "javascript", "html", "rust", "json5"
		  },
		  sync_install = false,
		  highlight = { enable = true },
		  indent = { enable = true },
	  })
	end
}
