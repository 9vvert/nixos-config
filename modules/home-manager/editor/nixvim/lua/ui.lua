local map = vim.keymap.set

require("nvim-web-devicons").setup({
    color_icons = true,
    default = true,
    strict = true,
    blend = 0,
})

require("night-owl").setup()
vim.cmd.colorscheme("night-owl")

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

require("dropbar").setup({
    bar = {
        enable = function(buf, win, _)
            if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
                return false
            end
            if vim.fn.win_gettype(win) ~= "" then
                return false
            end

            local disabled_filetypes = {
                ["neo-tree"] = true,
                help = true,
                terminal = true,
                Trouble = true,
            }

            return not disabled_filetypes[vim.bo[buf].filetype]
        end,
    },
    menu = {
        win_configs = {
            border = "rounded",
        },
    },
})
map("n", "<leader>;", require("dropbar.api").pick, { desc = "Pick breadcrumb" })

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
