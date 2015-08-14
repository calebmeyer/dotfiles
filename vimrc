set nocompatible              " be iMproved
set encoding=utf-8

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
  Plugin 'ntpeters/vim-better-whitespace'
  Plugin 'andrwb/vim-lapis256'
  Plugin 'ConradIrwin/vim-bracketed-paste'
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

" Line numbers
set number

" Syntax Highlighting
syntax on
set t_Co=256
set background=dark
colorscheme lapis256

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

set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab         " use spaces instead of tabs when a lot of indentation is needed

set incsearch

" Make backspace work in mac
set backspace=indent,eol,start

" .md means markdown, not modula2
autocmd BufNewFile,BufRead *.md set filetype=markdown

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif


" Nerd Tree settings
" use ctrl n to toggle nerd tree
map <C-n> :NERDTreeToggle<CR>

" use jj to exit insert mode
:imap jj <Esc>

" Buffer switching with tab
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

" fold and unfold in normal mode with space. Fold in visual mode with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" ; works just as well as : for normal mode! Saves hitting shift all the time
nnoremap ; :

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

let mapleader = ","   " use comma as the leader character

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
map <Leader>rit :! bundle exec ruby spec/integration/integration.rb<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e ~/.vimrc<CR>
nmap <silent> <leader>sv :so ~/.vimrc<CR>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
