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
