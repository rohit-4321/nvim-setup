vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true


vim.cmd([[
  augroup GoFileKeymaps
    autocmd!
    autocmd FileType go nnoremap <buffer> <C-s> :w<CR>:!gofmt -w %<CR><CR>
  augroup END
]])

vim.keymap.set("i", "<C-Enter>", "<C-o>O")

--Preview Keymaps
vim.keymap.set("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", {noremap=true})
vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", {noremap=true})
vim.keymap.set("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", {noremap=true})
vim.keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", {noremap=true})

-- Adding current branch name to status bar
local function branch_name()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
	if branch ~= "" then
		return branch
	else
		return ""
	end
end


vim.api.nvim_create_autocmd({"FileType", "BufEnter", "FocusGained"}, {
	callback = function()
		vim.b.branch_name = branch_name()
	end
})
