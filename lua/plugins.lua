-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

use 'nvim-treesitter/nvim-treesitter'
use 'wbthomason/packer.nvim'
use 'bhurlow/vim-parinfer'
use 'roxma/nvim-yarp'
use { 'neoclide/coc.nvim', run = 'yarn install' }
use 'LnL7/vim-nix'
use 'othree/html5.vim'
use 'tpope/vim-surround'
use 'chrisbra/SudoEdit.vim'
use 'pangloss/vim-javascript'
use 'scrooloose/nerdcommenter'
use 'scrooloose/nerdtree'
use 'mattn/emmet-vim'
use 'plasticboy/vim-markdown'
use 'jiangmiao/auto-pairs'
use 'rust-lang/rust.vim'
use 'Matt-Deacalion/vim-systemd-syntax'
use 'leafgarland/typescript-vim'
use 'junegunn/fzf'
use 'reasonml-editor/vim-reason-plus'
use 'vim-scripts/Lucius'
use 'vim-airline/vim-airline'
use { 'vim-airline/vim-airline-themes', requires = { 'vim-airline' }}
use 'bling/vim-bufferline'
use { 'ternjs/tern_for_vim', run = 'npm install' }
use 'kana/vim-arpeggio'
use 'editorconfig/editorconfig-vim'
use 'udalov/kotlin-vim'
use 'junegunn/fzf.vim'
use 'ziglang/zig.vim'
use 'wsdjeg/dein-ui.vim'
use { 'liuchengxu/vim-which-key', opt = true, cmd = { 'WhichKey' }}
use 'liuchengxu/vista.vim'
end)
