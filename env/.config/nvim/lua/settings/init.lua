vim.cmd [[
set autoindent
set expandtab
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4

set nu
set relativenumber

set nohlsearch
set incsearch
set scrolloff:8
set updatetime:50
]]

vim.g.mapleader = " "

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
--  delete without copy
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("i", "<c-c>", "<esc>")

-- remove arrows
vim.keymap.set({"n","v","i"}, "<Up>", "")
vim.keymap.set({"n","v","i"}, "<Down>", "")
vim.keymap.set({"n","v","i"}, "<Left>", "")
vim.keymap.set({"n","v","i"}, "<Right>", "")

system = vim.loop.os_uname().sysname
if (string.find(system, "Windows")) then
    vim.cmd[[
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -noprofile -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';'
    let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    let &shellpipe  = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
    set shellquote= shellxquote=
    ]]
end
