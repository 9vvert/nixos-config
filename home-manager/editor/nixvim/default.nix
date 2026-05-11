{ pkgs, inputs, ... }:

let
  treesitterWithParsers = pkgs.vimPlugins.nvim-treesitter.withPlugins (parsers:
    with parsers; [
      asm
      bash
      c
      cmake
      cpp
      go
      java
      javascript
      json
      latex
      llvm
      lua
      make
      markdown
      markdown_inline
      nix
      objdump
      python
      rust
      typescript
      yaml
    ]);
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      asm-lsp
      ast-grep
      awk-language-server
      clang-tools
      cmake-language-server
      fd
      haskell-language-server
      lua-language-server
      ocamlPackages.ocaml-lsp
      pyright
      ripgrep
      ruby-lsp
      rust-analyzer
      stylua
      typescript-language-server
      yaml-language-server
    ];

    extraPlugins = [ treesitterWithParsers ] ++ (with pkgs.vimPlugins; [
      base16-nvim
      blink-cmp
      bufferline-nvim
      bufdelete-nvim
      codecompanion-nvim
      comment-nvim
      conform-nvim
      copilot-lsp
      copilot-lua
      cyberdream-nvim
      fidget-nvim
      flash-nvim
      friendly-snippets
      gitsigns-nvim
      lualine-nvim
      midnight-nvim
      neo-tree-nvim
      night-owl-nvim
      nightfox-nvim
      noice-nvim
      nui-nvim
      nvim-autopairs
      nvim-lspconfig
      nvim-notify
      nvim-surround
      nvim-web-devicons
      orgmode
      plenary-nvim
      render-markdown-nvim
      statuscol-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-ui-select-nvim
      tiny-inline-diagnostic-nvim
      todo-comments-nvim
      trouble-nvim
      which-key-nvim
    ]);

    extraConfigLua = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "
      vim.g.have_nerd_font = true

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      vim.opt.termguicolors = true
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.mouse = "a"
      vim.opt.showmode = false
      vim.opt.breakindent = true
      vim.opt.undofile = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.signcolumn = "yes"
      vim.opt.updatetime = 250
      vim.opt.timeoutlen = 300
      vim.opt.splitright = true
      vim.opt.splitbelow = true
      vim.opt.list = true
      vim.opt.listchars = { tab = "> ", trail = ".", nbsp = "+" }
      vim.opt.inccommand = "split"
      vim.opt.cursorline = true
      vim.opt.scrolloff = 10
      vim.opt.confirm = true
      vim.opt.whichwrap = "b,s"

      vim.schedule(function()
        vim.opt.clipboard = "unnamedplus"
      end)

      local map = vim.keymap.set
      map("n", ";", ":", { desc = "CMD enter command mode" })
      map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
      map({ "n", "v" }, "<M-h>", "5h")
      map({ "n", "v" }, "<M-j>", "5j")
      map({ "n", "v" }, "<M-k>", "5k")
      map({ "n", "v" }, "<M-l>", "5l")
      map({ "", "i", "c" }, "<LeftMouse>", "<Nop>")
      map({ "", "i", "c" }, "<LeftRelease>", "<Nop>")
      map({ "", "i", "c" }, "<2-LeftMouse>", "<Nop>")
      map({ "", "i", "c" }, "<RightMouse>", "<Nop>")
      map({ "", "i", "c" }, "<MiddleMouse>", "<Nop>")

      require("night-owl").setup()
      vim.cmd.colorscheme("night-owl")

      require("nvim-surround").setup({})
      require("nvim-autopairs").setup({})
      require("Comment").setup({})
      require("fidget").setup({})
      require("flash").setup({})
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "-" },
          changedelete = { text = "~" },
        },
      })

      require("lualine").setup({
        options = {
          theme = "auto",
        },
      })

      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          separator_style = "thin",
          show_buffer_close_icons = false,
          show_close_icon = false,
        },
      })
      map("n", "<M-,>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
      map("n", "<M-.>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
      map("n", "<M-/>", function()
        require("bufdelete").bufdelete(0, true)
      end, { desc = "Close buffer" })

      require("conform").setup({
        notify_on_error = false,
        format_on_save = function(bufnr)
          local disable_filetypes = { c = true, cpp = true, yml = true, yaml = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return nil
          end
          return {
            timeout_ms = 500,
            lsp_format = "fallback",
          }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          yml = {},
          yaml = {},
        },
      })
      map("", "<leader>f", function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end, { desc = "[F]ormat buffer" })

      require("blink.cmp").setup({
        keymap = {
          preset = "default",
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
          per_filetype = {
            codecompanion = { "codecompanion" },
          },
        },
      })

      require("nvim-treesitter.configs").setup({
        ensure_installed = {},
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })

      require("tiny-inline-diagnostic").setup({
        preset = "powerline",
        transparent_bg = false,
        transparent_cursorline = true,
        options = {
          focusable = true,
          show_source = {
            enabled = false,
            if_many = false,
          },
          use_icons_from_diagnostic = false,
          set_arrow_to_diag_color = true,
          add_messages = true,
          throttle = 20,
          softwrap = 30,
          multilines = {
            enabled = false,
            always_show = false,
            trim_whitespaces = false,
            tabstop = 4,
          },
          show_all_diags_on_cursorline = false,
          enable_on_insert = false,
          enable_on_select = false,
          overflow = {
            mode = "wrap",
            padding = 16,
          },
          break_line = {
            enabled = false,
            after = 30,
          },
          virt_texts = {
            priority = 2048,
          },
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },
        },
        disabled_ft = {},
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = {
          severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR,
          },
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E ",
            [vim.diagnostic.severity.WARN] = "W ",
            [vim.diagnostic.severity.INFO] = "I ",
            [vim.diagnostic.severity.HINT] = "H ",
          },
        },
        virtual_text = false,
      })

      vim.api.nvim_set_hl(0, "DiagnosticError", {
        fg = "#ff6c6b",
        bg = "NONE",
      })
      vim.api.nvim_set_hl(0, "TinyInlineDiagnosticVirtualTextError", {
        fg = "#f5abba",
        bg = "#4f3b4d",
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(event)
          local function lsp_map(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          lsp_map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
          lsp_map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
          lsp_map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          lsp_map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          lsp_map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          lsp_map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          lsp_map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
          lsp_map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
          lsp_map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "user-lsp-highlight", buffer = event2.buf })
              end,
            })
          end

          if client and client.supports_method and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            lsp_map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local servers = {
        ast_grep = {},
        clangd = {},
        cmake = {},
        pyright = {},
        ruby_lsp = {},
        rust_analyzer = {},
        ts_ls = {},
        yamlls = {},
        asm_lsp = {},
        awk_ls = {},
        ocamllsp = {},
        hls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      }

      local lspconfig = require("lspconfig")
      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        lspconfig[server_name].setup(server)
      end

      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require("telescope.builtin")
      map("n", "<leader>shp", builtin.help_tags, { desc = "[S]earch [H]el[p]" })
      map("n", "<leader>skm", builtin.keymaps, { desc = "[S]earch [K]ey[m]aps" })
      map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      map("n", "<leader>se", builtin.resume, { desc = "[S]earch R[e]sume" })
      map("n", "<leader>sr", builtin.registers, { desc = "[S]earch [R]e[g]ister" })
      map("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files" })
      map("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })
      map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      map("n", "<leader>sa", builtin.marks, { desc = "[S]earch [M]ark" })
      map("n", "<leader>lsw", builtin.lsp_workspace_symbols, { desc = "[L]ist [W]orkspace [S]ymbol" })
      map("n", "<leader>lsd", builtin.lsp_document_symbols, { desc = "[L]ist [D]ocument [S]ymbol" })
      map("n", "<leader>lts", builtin.treesitter, { desc = "[L]ist [T]ree[s]itter" })
      map("n", "<leader>lqf", builtin.quickfix, { desc = "[L]ist [Q]uickfix" })
      map("n", "<leader>lic", builtin.lsp_incoming_calls, { desc = "[L]ist [I]ncoming [C]alls" })
      map("n", "<leader>loc", builtin.lsp_outgoing_calls, { desc = "[L]ist [O]utgoing [C]alls" })
      map("n", "<leader>lr", builtin.lsp_references, { desc = "[L]ist [R]eference" })
      map("n", "<leader>ld", builtin.lsp_definitions, { desc = "[L]ist [D]efinition" })
      map("n", "<leader>lm", builtin.lsp_implementations, { desc = "[L]ist I[m]plementations" })
      map("n", "<leader>ltd", builtin.lsp_type_definitions, { desc = "[L]ist [T]ype [D]efinition" })
      map("n", "<leader>sb", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "Fuzzily search in current buffer" })
      map("n", "<leader>s/", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end, { desc = "[S]earch in Open Files" })
      map("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[S]earch [N]eovim files" })

      require("neo-tree").setup({
        window = {
          width = 30,
          auto_expand_width = true,
        },
      })
      map("n", "<M-r>", "<cmd>Neotree show toggle<CR>", { desc = "File explorer" })
      map("n", "<M-R>", ":Neotree ", { desc = "File explorer command" })

      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = false,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })

      require("notify").setup({
        render = "wrapped-default",
        timeout = 3,
        max_width = 50,
        max_height = 8,
      })
      vim.notify = require("notify")
      map("n", "<leader>si", "<cmd>Telescope notify<CR>", { desc = "[S]earch [N]otifications" })

      local function lnum_both()
        local lnum = vim.v.lnum
        local relnum = vim.v.lnum == vim.fn.line(".") and 0 or math.abs(vim.v.lnum - vim.fn.line("."))
        return string.format("%3d %2d", lnum, relnum)
      end
      vim.api.nvim_set_hl(0, "current_vert_split", { fg = "#ffa500", bg = "NONE" })
      require("statuscol").setup({
        setopt = true,
        ft_ignore = { "neo-tree" },
        segments = {
          {
            sign = {
              namespace = { "gitsigns.*" },
              name = { "gitsigns.*" },
            },
          },
          {
            text = { lnum_both, " " },
            condition = {
              function()
                return vim.v.lnum ~= vim.fn.line(".")
              end,
            },
            click = "v:lua.ScLa",
          },
          {
            text = { lnum_both, " " },
            hl = "current_vert_split",
            condition = {
              function()
                return vim.v.lnum == vim.fn.line(".")
              end,
            },
            click = "v:lua.ScLa",
          },
          {
            sign = {
              maxwidth = 1,
              fillchar = " ",
              namespace = { ".*" },
              name = { ".*" },
              auto = false,
            },
          },
          {
            text = { " . " },
            condition = {
              function()
                return vim.v.lnum ~= vim.fn.line(".")
              end,
            },
          },
          {
            text = { "-> " },
            hl = "current_vert_split",
            condition = {
              function()
                return vim.v.lnum == vim.fn.line(".")
              end,
            },
          },
        },
      })

      require("todo-comments").setup({
        signs = false,
        keywords = {
          FIX = { icon = "FIX", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = "TODO", color = "todo" },
          HACK = { icon = "HACK", color = "warning" },
          WARN = { icon = "WARN", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = "PERF", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = "NOTE", color = "hint", alt = {} },
          INFO = { icon = "INFO", color = "info", alt = { "SOME", "TIP" } },
          TIP = { icon = "TIP", color = "tip", alt = {} },
          DEBUG = { icon = "DEBUG", color = "debug", alt = {} },
          TEST = { icon = "TEST", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        colors = {
          error = { "#DC2626" },
          warning = { "#f59842" },
          todo = { "#e0e86d" },
          info = { "#2563EB" },
          hint = { "#10B981" },
          default = { "#7C3AED" },
          debug = { "#5C3AED" },
          test = { "#FF00FF" },
          tip = { "#7d888a" },
        },
      })

      require("trouble").setup({})
      map("n", "<leader>xx", "<cmd>Trouble<CR>", { desc = "Open Trouble panels" })
      map("n", "<leader>xD", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
      map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer diagnostics" })
      map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", { desc = "Symbols" })
      map("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", { desc = "LSP Trouble" })
      map("n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>", { desc = "Location list" })
      map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix list" })

      require("orgmode").setup({
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      })

      require("render-markdown").setup({
        file_types = { "markdown", "codecompanion" },
      })

      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })

      require("codecompanion").setup({
        interactions = {
          chat = {
            adapter = {
              name = "copilot",
              model = "gpt-4.1",
            },
          },
          inline = {
            adapter = {
              name = "copilot",
              model = "gpt-4.1",
            },
          },
          cmd = {
            adapter = {
              name = "copilot",
              model = "gpt-4.1",
            },
          },
          background = {
            adapter = {
              name = "copilot",
              model = "gpt-4.1",
            },
          },
        },
        opts = {
          log_level = "DEBUG",
        },
      })
      map({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Toggle CodeCompanion chat" })
    '';
  };
}
