return {
  {
    "williamboman/mason.nvim",
    lazy = false,
	opts = { ensure_installed = { "java-debug-adapter", "java-test", "ktlint" } },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
	opts = { servers = {
				jdtls = function() return true end,
				kotlin_language_server = {},
				jsonls = {
					-- lazy-load schemastore when needed
					on_new_config = function(new_config)
					  new_config.settings.json.schemas = new_config.settings.json.schemas or {}
					  vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
					end,
					settings = {
					  json = {
						format = {
						  enable = true,
						},
						validate = { enable = true },
					  },
					},
				},
			}
	},
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.tsserver.setup({ capabilities = capabilities })
      lspconfig.solargraph.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({ capabilities = capabilities })
	  lspconfig.jdtls.setup({
				capabilities = capabilities,
				settings = {
					java = {
						configuration = {
							runtimes = {
							  {
								name = "Java-17",
								path = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home",
								default = true,
							  },

							  {
								name = "Java-11",
								path = "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home",
							  },

							  {
								name = "Java-8",
								path = "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home",
							  }
							}
						}
					}
				}
			})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
