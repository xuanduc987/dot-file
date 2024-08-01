-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "farmergreg/vim-lastplace",

  {
    "jpalardy/vim-slime",
    init = function()
      vim.g.slime_target = "neovim"
    end,
  },

  { "numToStr/Comment.nvim", opts = {} },

  {
    "ibhagwan/fzf-lua",
    config = function()
      require("fzf-lua").setup({})
      require("fzf-lua").register_ui_select()

      vim.keymap.set("n", "<leader>o", "<cmd>lua require('fzf-lua').files()<CR>")
      vim.keymap.set("n", "<leader>b", "<cmd>lua require('fzf-lua').buffers()<CR>")
    end,
  },

  "bronson/vim-trailing-whitespace",

  {
    "romainl/vim-qf",
    config = function()
      vim.g.qf_shorten_path = 0
      vim.g.qf_auto_open_quickfix = 0
      vim.keymap.set("n", "<leader>c", "<Plug>(qf_qf_toggle)")
      vim.keymap.set("n", "<leader>l", "<Plug>(qf_loc_toggle)")
      vim.keymap.set("n", "<leader>z", ":pclose<CR>")
    end,
  },

  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    config = function()
      vim.keymap.set("n", "<leader>gs", ":tab Git<CR>")
    end,
  },

  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  {
    "stevearc/overseer.nvim",
    config = function()
      require("overseer").setup()
      vim.keymap.set("n", "<C-T>", "<cmd>OverseerRun<CR>")
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- adapters
      { "zidhuss/neotest-minitest", dev = true },
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        icons = {
          running_animated = { "◰", "◳", "◲", "◱" },
          passed = "✓",
          running = "⯈",
          failed = "✗",
          skipped = "-",
          unknown = "?",
          non_collapsible = "─",
          collapsed = "─",
          expanded = "╮",
          child_prefix = "├",
          final_child_prefix = "╰",
          child_indent = "│",
          final_child_indent = " ",
          watching = "⏿",
        },
        adapters = {
          require("neotest-minitest")({
            additional_base_test_classes = { "GraphqlIntegrationTest", "StudyGraphqlIntegrationTest" },
          }),
        },
      })
      vim.keymap.set("n", "<leader>tt", neotest.run.run)
      vim.keymap.set("n", "<leader>tw", neotest.watch.toggle)
      vim.keymap.set("n", "<leader>tf", function()
        neotest.run.run(vim.fn.expand("%"))
      end)
      vim.keymap.set("n", "<Leader>ts", neotest.summary.toggle)
      vim.keymap.set("n", "<leader>to", function()
        neotest.output.open({ enter = true, auto_close = true })
      end, { desc = "Show Output" })
      vim.keymap.set("n", "<leader>tO", function()
        neotest.output_panel.toggle()
      end, { desc = "Toggle Output Panel" })
    end,
  },

  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "catlee/pull_diags.nvim", event = "LspAttach", opts = {} }, -- pull diagnostics support for neovim < 0.10

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      { "folke/neodev.nvim", opts = {} },

      "yioneko/nvim-vtsls",
      -- {
      --   "pmizio/typescript-tools.nvim",
      --   dependencies = { "nvim-lua/plenary.nvim" },
      --   opts = {},
      -- },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map(
            "gd",
            '<cmd>lua require("fzf-lua").lsp_definitions({ jump_to_single_result = true })<cr>',
            "[G]oto [D]efinition"
          )
          map(
            "gr",
            '<cmd>lua require("fzf-lua").lsp_references({ jump_to_single_result = true })<cr>',
            "[G]oto [R]eferences"
          )
          map(
            "gI",
            '<cmd>lua require("fzf-lua").lsp_implementations({ jump_to_single_result = true })<cr>',
            "[G]oto [I]mplementation"
          )
          map(
            "<leader>d",
            '<cmd>lua require("fzf-lua").lsp_typedefs({ jump_to_single_result = true })<cr>',
            "Type [D]efinition"
          )
          map("gR", vim.lsp.buf.rename, "[R]e[n]ame")
          map("ga", vim.lsp.buf.code_action, "[C]ode [A]ction")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      require("mason").setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code

        "efm",
        "vtsls",
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    lazy = false,
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

  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",

      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = function()
      -- See `:help cmp`
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },

        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          -- Scroll the documentation window [b]ack / [f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          ["<Tab>"] = cmp.mapping.confirm({ select = true }),

          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-e>"] = cmp.mapping.complete({}),

          ["<C-j>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
          { name = "nvim_lsp_signature_help" },
        },
      })
    end,
  },

  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        command = "set background=dark | colorscheme rosebones",
      })
    end,
  },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      require("mini.align").setup({
        mappings = {
          start = "<Plug>(minialign-start)",
          start_with_preview = "<Plug>(minialign-start-with-preview)",
        },
      })
      vim.keymap.set("x", "<CR>", "<Plug>(minialign-start-with-preview)")

      require("mini.pairs").setup({})
      require("mini.surround").setup()

      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = false })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },

  {
    "justinmk/vim-dirvish",
    config = function()
      vim.keymap.set("n", "-", "<Plug>(dirvish_up)")
    end,
  },

  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
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
  dev = {
    path = "~/ghq/github.com/zidhuss",
    fallback = false,
  },
})
