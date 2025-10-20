-- set leader keys before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.timeoutlen = 2000 -- better timeout lenght

-- force Escape key to always work
vim.keymap.set('i', '<Esc>', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true }) -- Alternative: type 'jk' quickly

-- save and quit with leader keys
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = 'Save file' })
vim.keymap.set('n', '<leader>q', ':wq<CR>', { noremap = true, silent = true, desc = 'Save and quit' })
vim.keymap.set('n', '<leader>Q', ':q!<CR>', { noremap = true, silent = true, desc = 'Quit without saving' })

-- go to beginning and end of file
vim.keymap.set('n', '<leader>gg', 'gg', { noremap = true, silent = true, desc = 'Go to beginning of file' })
vim.keymap.set('n', '<leader>G', 'G', { noremap = true, silent = true, desc = 'Go to end of file' })

-- highlight current line number
vim.api.nvim_set_hl(0, 'LineNr', { bold = true })

-- load vim options for defaults
require('options')

-- load vim autoclose for closing quotes and paretheses
require('autoclose').setup()

-- plugins
-- lazy.nvim setup

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- setup plugins via lazy.nvim
require('lazy').setup('plugins', {
    change_detection = { enabled = true, notify = false },
})

-- load treesitter configuration
require('treesitter-config')

-- load completion configuration (only if nvim-cmp is installed)
local cmp_ok, _ = pcall(require, 'cmp')
if cmp_ok then
    require('completion-config')
end

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
