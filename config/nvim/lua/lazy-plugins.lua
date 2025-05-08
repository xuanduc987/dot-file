-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "farmergreg/vim-lastplace",
    event = "BufReadPost",
  },

  {
    "jpalardy/vim-slime",
    keys = { { "<C-c><C-c>" }, { "<C-c>v" } },
    init = function()
      vim.g.slime_target = "neovim"
    end,
  },

  {
    "romainl/vim-qf",
    event = "BufReadPost",
    config = function()
      vim.g.qf_shorten_path = 0
      vim.g.qf_auto_open_quickfix = 0
      vim.keymap.set("n", "<leader>c", "<Plug>(qf_qf_toggle)")
      vim.keymap.set("n", "<leader>l", "<Plug>(qf_loc_toggle)")
      vim.keymap.set("n", "<leader>z", ":pclose<CR>")
    end,
  },

  {
    "vim-test/vim-test",
    keys = {
      { "<leader>tt", "<cmd>TestNearest<CR>" },
      { "<leader>tf", "<cmd>TestFile<CR>" },
      { "<leader>ta", "<cmd>TestSuite<CR>" },
      { "<leader>tl", "<cmd>TestLast<CR>" },
      { "<leader>tg", "<cmd>TestVisit<CR>" },
    },
    config = function()
      vim.g["test#strategy"] = "dispatch"
    end,
  },
  {
    "tpope/vim-dispatch",
    cmd = { "Make", "Dispatch", "ForcusDispatch", "AbortDispatch" },
    keys = {
      { "<leader>d", ":Dispatch<space>" },
      { "<leader>r", "<cmd>Dispatch<CR>" },
    },
    config = function()
      vim.g.dispatch_compilers = { yarn = "", npx = "" }
      vim.g.dispatch_no_tmux_make = 1
      vim.g.dispatch_no_tmux_start = 1
    end,
  },

  {
    "dmmulroy/tsc.nvim",
    opts = {},
    ft = { "typescript", "typescriptreact" },
  },

  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    dependencies = {
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {},
      },

      {
        "yioneko/nvim-vtsls",
        ft = { "typescript", "typescriptreact" },
      },

      {
        "b0o/schemastore.nvim",
        ft = { "json" },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
          map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
          map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
          map("<leader>gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
          map("gR", vim.lsp.buf.rename, "[R]e[n]ame")
          map("ga", vim.lsp.buf.code_action, "[C]ode [A]ction")
          vim.keymap.set(
            "x",
            "ga",
            vim.lsp.buf.code_action,
            { buffer = event.buf, desc = "LSP: " .. "[C]ode [A]ction" }
          )
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        end,
      })

      local servers = {
        efm = {},
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
            },
          },
        },
        html = {},
        cssls = {},
        yamlls = {},
        ruby_lsp = {},
        sorbet = {},
        vtsls = {
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
            },
            javascript = { suggest = { completeFunctionCalls = false } },
            typescript = { suggest = { completeFunctionCalls = false } },
          },
        },
        nixd = {
          settings = {
            nixd = {
              formatting = { command = { "alejandra", "-qq" } },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
      }

      for server, config in pairs(servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    keys = {
      {
        "g=",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_format = (not disable_filetypes[vim.bo[bufnr].filetype]) and "fallback" or nil,
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- Disable cmdline
      cmdline = {
        enabled = false,
      },
      keymap = {
        preset = "default",
        ["<C-e>"] = { "show", "show_documentation", "hide_documentation" },
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<C-j>"] = { "snippet_forward", "fallback" },
        ["<C-k>"] = { "snippet_backward", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      snippets = { preset = "mini_snippets" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true },
      completion = {
        accept = {
          auto_brackets = { enabled = false },
        },
      },
    },
  },

  -- {
  --   "https://gitlab.com/protesilaos/tempus-themes-vim.git",
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     vim.api.nvim_create_autocmd("VimEnter", {
  --       nested = true,
  --       command = "colorscheme tempus_day",
  --     })
  --   end,
  -- },

  {
    "rebelot/kanagawa.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.o.background = "dark"
      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        command = "colorscheme kanagawa",
      })
    end,
  },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    event = { "VeryLazy" },

    config = function()
      -- a/i textobjects
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.align").setup({
        mappings = {
          start = "<Plug>(minialign-start)",
          start_with_preview = "<Plug>(minialign-start-with-preview)",
        },
      })
      vim.keymap.set("x", "<CR>", "<Plug>(minialign-start-with-preview)")

      require("mini.pairs").setup()
      require("mini.icons").setup()
      require("mini.surround").setup({
        respect_selection_type = true,
      })

      local statusline = require("mini.statusline")
      statusline.setup()

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      require("mini.pick").setup()
      vim.keymap.set("n", "<leader>o", "<cmd>Pick files<CR>")
      vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<CR>")

      require("mini.trailspace").setup()
      vim.api.nvim_create_user_command("FixWhitespace", MiniTrailspace.trim, {})

      require("mini.snippets").setup()
      local make_stop = function()
        local au_opts = { pattern = "*:n", once = true }
        au_opts.callback = function()
          while MiniSnippets.session.get() do
            MiniSnippets.session.stop()
          end
        end
        vim.api.nvim_create_autocmd("ModeChanged", au_opts)
      end
      local opts = { pattern = "MiniSnippetsSessionStart", callback = make_stop }
      vim.api.nvim_create_autocmd("User", opts)
      require("mini.git").setup()
    end,
  },

  {
    "justinmk/vim-dirvish",
    lazy = false,
    keys = { "-", "<Plug>(dirvish_up)" },
  },

  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
      ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby", "graphql" } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require("nvim-treesitter.install").prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
}, {
  defaults = { lazy = true },
  install = { colorscheme = { "kanagawa" } },
  ui = { border = "rounded" },
  performance = {
    rtp = {
      disabled_plugins = {
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
