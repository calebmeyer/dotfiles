set nocompatible              " be iMproved
set encoding=utf-8
set t_Co=256

set shell=/bin/bash
let $VIMRUNTIME = '/usr/local/Cellar/macvim/7.4-74/MacVim.app/Contents/Resources/vim/runtime'

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

  " let Vundle manage Vundle, required
  Plugin 'gmarik/Vundle.vim'

  " Keep Plugin commands between vundle#begin/end.
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-haml'
  Plugin 'tpope/vim-rails'
  Plugin 'scrooloose/nerdtree'
  Plugin 'kien/ctrlp.vim'
  Plugin 'bling/vim-airline'
  Plugin 'groenewege/vim-less'
  Plugin 'gosukiwi/vim-atom-dark'
  Plugin 'godlygeek/tabular'
  Plugin 'plasticboy/vim-markdown'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'tpope/vim-surround'
  Plugin 'fatih/vim-go'
  Plugin 'thoughtbot/vim-rspec'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" use jj to exit insert mode
:imap jj <Esc>

" Line numbers
set number

" Set the rulers at 80 characters and 120 characters.
set cc=80,120
highlight ColorColumn ctermbg=DarkGray

set scrolloff=8 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" Turn off swapfiles
set noswapfile
set nobackup
set nowb

set autoindent        " indent the next line to the same depth as this one
set smartindent       " indent the next line one deeper, when appropriate
set shiftwidth=2      " the next few lines are all to set tabs as 2 spaces, by default
set softtabstop=2
set tabstop=2
set expandtab         " use spaces instead of tabs when a lot of indentation is needed

let mapleader = ","   " use comma as the leader character

" Nerd Tree settings
" use ctrl n to toggle nerd tree
map <C-n> :NERDTreeToggle<CR>

" close vim if nerd tree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" .md means markdown, not modula2
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Buffer switching with tab
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

" Ctrl + P doesn't search in these places
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '/target'

" Airline related
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" fold and unfold in normal mode with space. Fold in visual mode with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" fugitive shortcuts
noremap <leader>gs :Gstatus<cr>
noremap <leader>gc :Gcommit<cr>
noremap <leader>ga :Git add -A<cr>
noremap <leader>gl :Glog<cr>
noremap <leader>gd :Gdiff<cr>
noremap <leader>gb :Gblame<cr>
noremap <leader>gp :Gpush<cr>


" settings for rspec
let g:rspec_runner = "os_x_iterm"
map <Leader>rf :call RunCurrentSpecFile()<CR>
map <Leader>rc :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>rr :call RunAllSpecs()<CR>
