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
  "eslint",
  "vtsls",
  "pyright",
}

vim.lsp.config("pyright", {
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
})

vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    if client.name == "vtsls" then
      -- Define a command to organize imports
      vim.api.nvim_buf_create_user_command(args.buf, "OrganizeImports", function()
        vim.lsp.buf.code_action {
          context = { only = { "source.organizeImports" }, diagnostics = {} },
          apply = true,
        }
      end, { desc = "Organize imports using vtsls" })
    elseif client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        command = "LspEslintFixAll",
      })
    end
  end,
})
