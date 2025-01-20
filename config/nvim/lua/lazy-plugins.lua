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
      require("fzf-lua").register_ui_select(function(fzf_opts, _)
        if
          fzf_opts.kind == "codeaction" and not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0, name = "vtsls" }))
        then
          return vim.tbl_deep_extend("force", fzf_opts, {
            winopts = {
              preview = { hidden = "hidden" },
            },
          })
        else
          return fzf_opts
        end
      end)

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
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "dispatch"
      vim.keymap.set("n", "<leader>tt", "<cmd>TestNearest<CR>")
      vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<CR>")
      vim.keymap.set("n", "<leader>ta", "<cmd>TestSuite<CR>")
      vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<CR>")
      vim.keymap.set("n", "<leader>tg", "<cmd>TestVisit<CR>")
    end,
  },
  {
    "tpope/vim-dispatch",
    config = function()
      vim.g.dispatch_compilers = { yarn = "", npx = "" }
      vim.g.dispatch_no_tmux_make = 1
      vim.g.dispatch_no_tmux_start = 1
      vim.keymap.set("n", "<leader>d", ":Dispatch<space>")
      vim.keymap.set("n", "<leader>r", "<cmd>Dispatch<CR>")
    end,
  },

  {
    "dmmulroy/tsc.nvim",
    opts = {},
    ft = { "typescript", "typescriptreact" },
  },

  { -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
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

      "b0o/schemastore.nvim",
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
            -- '<cmd>lua require("fzf-lua").lsp_definitions({ jump_to_single_result = true })<cr>',
            vim.lsp.buf.definition,
            "[G]oto [D]efinition"
          )
          map(
            "gr",
            -- '<cmd>lua require("fzf-lua").lsp_references({ jump_to_single_result = true })<cr>',
            vim.lsp.buf.references,
            "[G]oto [R]eferences"
          )
          map(
            "gI",
            -- '<cmd>lua require("fzf-lua").lsp_implementations({ jump_to_single_result = true })<cr>',
            vim.lsp.buf.implementation,
            "[G]oto [I]mplementation"
          )
          map(
            "<leader>gt",
            -- '<cmd>lua require("fzf-lua").lsp_typedefs({ jump_to_single_result = true })<cr>',
            vim.lsp.buf.type_definition,
            "[G]oto [T]ype Definition"
          )
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

      -- capabilities = require("cmp_nvim_lsp").default_capabilities()

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

      local lspconfig = require("lspconfig")
      for server, config in pairs(servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    -- branch = "nvim-0.9",
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
  {
    "saghen/blink.cmp",
    version = "*",

    dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
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
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        -- Disable cmdline completions
        cmdline = {},
      },
      signature = { enabled = true },
    },
  },

  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    enabled = false,
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
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
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

  -- {
  --   "mcchrish/zenbones.nvim",
  --   dependencies = { "rktjmp/lush.nvim" },
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     vim.api.nvim_create_autocmd("VimEnter", {
  --       nested = true,
  --       command = "set background=dark | colorscheme rosebones",
  --     })
  --   end,
  -- },

  {
    "https://gitlab.com/protesilaos/tempus-themes-vim.git",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        command = "colorscheme tempus_day",
      })
    end,
  },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
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
})
