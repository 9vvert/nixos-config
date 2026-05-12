local map = vim.keymap.set

require("todo-comments").setup({
    signs = false,
    keywords = {
        FIX = { icon = "F", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = "T", color = "todo" },
        HACK = { icon = "H", color = "warning" },
        WARN = { icon = "W", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "P", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "N", color = "hint", alt = {} },
        INFO = { icon = "I", color = "info", alt = { "SOME", "TIP" } },
        TIP = { icon = ">", color = "tip", alt = {} },
        DEBUG = { icon = "D", color = "debug", alt = {} },
        TEST = { icon = "OK", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
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

require("which-key").setup({})

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
