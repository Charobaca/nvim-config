source $HOME/.config/nvim/plug-config/coc.vim

set mouse=a  " enable mouse
set encoding=utf-8
set number
set noswapfile
set scrolloff=7

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix
filetype indent on      " load filetype-specific indent files

" for tabulation
set smartindent


" copy and paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

inoremap jk <esc>

call plug#begin('~/.vim/plugged')

Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'chrisbra/vim-commentary'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'bmatcuk/stylelint-lsp'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

Plug 'morhetz/gruvbox' 

" Plug 'xiyaowong/nvim-transparent'

Plug 'justinmk/vim-sneak'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }



call plug#end()


" Leader bind to space
let mapleader = ","

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Netrw file explorer settings
let g:netrw_banner = 0 " hide banner above files
let g:netrw_liststyle = 3 " tree instead of plain view
let g:netrw_browse_split = 3 " vertical split window when Enter pressed on file


" Turn on vim-sneak
let g:sneak#label = 1

colorscheme gruvbox

" turn off search highlight
noremap ,<space> :nohlsearch<CR>


lua << EOF
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

local async = require "plenary.async"

-- luasnip setup
local luasnip = require 'luasnip'
local nvim_lsp = require('lspconfig')

local servers = { 'pyright', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
nvim_lsp[lsp].setup {
on_attach = on_attach,
flags = {
debounce_text_changes = 150,
}
}
end

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettier
    },
    on_attach = on_attach
})

-- Stylelint format after save
require'lspconfig'.stylelint_lsp.setup{
  settings = {
    stylelintplus = {
      --autoFixOnSave = true,
      --autoFixOnFormat = true,
    }
  }
}

vim.opt.list = true
vim.opt.listchars:append ""

require("indent_blankline").setup {
show_end_of_line = true,
}


EOF

function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Automatically format frontend files with prettier after file save
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" Disable quickfix window for prettier
let g:prettier#quickfix_enabled = 0

" Run Python and C files by Ctrl+h
autocmd FileType python map <buffer> <C-h> :w<CR>:exec '!python3.10' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <C-h> <esc>:w<CR>:exec '!python3.10' shellescape(@%, 1)<CR>

autocmd FileType c map <buffer> <C-h> :w<CR>:exec '!gcc' shellescape(@%, 1) '-o out; ./out'<CR>
autocmd FileType c imap <buffer> <C-h> <esc>:w<CR>:exec '!gcc' shellescape(@%, 1) '-o out; ./out'<CR>

autocmd FileType python set colorcolumn=79

set relativenumber
set rnu

" let g:transparent_enabled = v:true

tnoremap <Esc> <C-\><C-n>

nnoremap H gT
nnoremap L gt

set termguicolors
hi DiagnosticError guifg=Red
hi DiagnosticWarn  guifg=Yellow
hi DiagnosticInfo  guifg=Green
hi DiagnosticHint  guifg=White
