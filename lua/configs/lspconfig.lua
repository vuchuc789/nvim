-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local configs = require "nvchad.configs.lspconfig"

local servers = {
  "html",
  "cssls",
  "yamlls",
  "dockerls",
  "docker_compose_language_service",
  "terraformls",
  "ansiblels",
  "gopls",
  "helm_ls",
  "bashls",
  "rust_analyzer",
  "tailwindcss",
  "ruff",
  -- "eslint",
  -- "vtsls",
  -- "pyright",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = configs.on_attach,
    on_init = configs.on_init,
    capabilities = configs.capabilities,
  }
end

lspconfig.vtsls.setup {
  on_attach = function(client, bufnr)
    -- Define a command to organize imports
    vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", function()
      vim.lsp.buf.code_action {
        context = { only = { "source.organizeImports" }, diagnostics = {} },
        apply = true,
      }
    end, { desc = "Organize imports using vtsls" })

    configs.on_attach(client, bufnr)
  end,
  on_init = configs.on_init,
  capabilities = configs.capabilities,
}

lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })

    configs.on_attach(client, bufnr)
  end,
  on_init = configs.on_init,
  capabilities = configs.capabilities,
}

lspconfig.pyright.setup {
  on_attach = configs.on_attach,
  on_init = configs.on_init,
  capabilities = configs.capabilities,
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { "*" },
      },
    },
  },
}
