call plug#begin()
Plug 'projekt0n/github-nvim-theme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
call plug#end()

" Options
set number "
colorscheme github_dark
let g:airline_theme='minimalist'
let mapleader=","

" Telescope Options
nnoremap <leader>ff <cmd>Telescope find_files<cr>
