local map = vim.keymap.set

require("nvim-surround").setup({})
require("nvim-autopairs").setup({})
require("Comment").setup({})
require("fidget").setup({})

require("flash").setup({})
map(
    { "n", "x", "o" }, "s", 
    function()
        require("flash").jump()
    end, { desc = "Flash" }
)
map({ "n", "x", "o" }, "S", function()
    require("flash").treesitter()
end, { desc = "Flash Treesitter" })
map("o", "r", function()
    require("flash").remote()
end, { desc = "Remote Flash" })
map({ "o", "x" }, "R", function()
    require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
map("c", "<C-s>", function()
    require("flash").toggle()
end, { desc = "Toggle Flash Search" })

require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
    },
})

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
