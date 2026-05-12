local map = vim.keymap.set

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
