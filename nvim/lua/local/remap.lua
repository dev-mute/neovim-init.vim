-- Open File Explorer --
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>")
vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeToggle<CR>")

-- Undo Tree --
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")

-- Telescope --
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope_builtin.git_files, {})
vim.keymap.set("n", "<leader>fs", telescope_builtin.live_grep, {})
-- Auto-session Session Lens
local session_lens = require("auto-session.session-lens")
vim.keymap.set("n", "<leader>ss", session_lens.search_session, {noremap = true,})

-- LSP --
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}
	lsp.default_keymaps({buffer = bufnr})

	vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)

	-- LSP finder - Find the symbol's definition
	vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)

	-- Code action
	vim.keymap.set({"n", "v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

	-- Rename all occurrences of the hovered word for the entire file
	vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>")
	-- Rename all occurrences of the hovered word for the selected files
	vim.keymap.set("n", "<leader>r", "<cmd>Lspsaga rename ++project<CR>", opts)

	vim.keymap.set("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>", opts)
	vim.keymap.set("n", "<leader>pT", "<cmd>Lspsaga peek_type_definition<CR>", opts)
	vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga goto_definition<CR>", opts)
	vim.keymap.set("n", "<leader>gT", "<cmd>Lspsaga goto_type_definition<CR>", opts)

	vim.keymap.set("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	vim.keymap.set("n", "<leader>db", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
	vim.keymap.set("n", "<leader>dw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts)
	vim.keymap.set("n", "<leader>dc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

	vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

	-- Diagnostic jump with filters such as only jumping to an error
	vim.keymap.set("n", "[E", function()
		require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end, opts)
	vim.keymap.set("n", "]E", function()
		require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
	end, opts)

	vim.keymap.set("n","<leader>o", "<cmd>Lspsaga outline<CR>", opts)

	vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

	vim.keymap.set("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
	vim.keymap.set("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

end)

-- Git --
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Movements --
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
