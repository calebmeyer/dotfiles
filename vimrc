set nocompatible              " be iMproved
set encoding=utf-8

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Keep Plugin commands between vundle#begin/end.
call vundle#begin()
  " let Vundle manage Vundle, required
  Plugin 'gmarik/Vundle.vim'


  " Git plugins
  Plugin 'tpope/vim-fugitive'
  Plugin 'airblade/vim-gitgutter'

  " Rails dev
  Plugin 'tpope/vim-haml'
  Plugin 'groenewege/vim-less'
  Plugin 'tpope/vim-rails'
  Plugin 'plasticboy/vim-markdown'
  Plugin 'bruno-/vim-ruby-fold'
  Plugin 'thoughtbot/vim-rspec'

  " File browser as a sidebar
  Plugin 'scrooloose/nerdtree'

  " Hit Ctrl+p to open files, similar to sublime/atom/textmate
  Plugin 'kien/ctrlp.vim'

  " Colorful statusline that shows buffers along the top
  Plugin 'bling/vim-airline'

  " Syntax highlighting for gui vim (macvim)
  Plugin 'gosukiwi/vim-atom-dark'
  Plugin 'flazz/vim-colorschemes'
  " and console vim
  Plugin 'andrwb/vim-lapis256'

  " :Tab /<character to align>
  Plugin 'godlygeek/tabular'

  " Adds a new adjective "s" for surrounding, e.g. cs"' will change from
  " double quotes to single quotes
  Plugin 'tpope/vim-surround'

  " golang development
  Plugin 'fatih/vim-go'

  " highlights trailing whitespace
  Plugin 'ntpeters/vim-better-whitespace'

  " fixes pasting to not successively indent further
  Plugin 'ConradIrwin/vim-bracketed-paste'

  " Session management
  Plugin 'tpope/vim-obsession'
  Plugin 'dhruvasagar/vim-prosession'

  " Block cursor on the command line!
  Plugin 'sjl/vitality.vim'

  " <leader> c to comment or uncomment the current line/selection
  Plugin 'scrooloose/nerdcommenter'

  " Rainbow parentheses
  Plugin 'luochen1990/rainbow'

  " Filetype icons
  Plugin 'ryanoasis/vim-devicons'
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

" Set the current line to be indicated via underline in the terminal, and
" background in macvim
set cursorline

" Turn off cursor blinking in gui vim
set guicursor+=a:blinkon0

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

" incrementally search (search as you type)
set incsearch

" automatically write the buffer when focus moves to a different one.
set autowrite

" Make backspace work in mac
set backspace=indent,eol,start

" Folding settings
set nofoldenable " turn it back on with zi
set foldmethod=indent

set encoding=utf-8

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
map <C-n> :NERDTreeToggle<cr>
map <C-d> :edit .
map <leader>nt :edit .<cr>

" Nerd Commenter settings
" comments always leave a space after the comment symbol
" (e.g. '# comment' or '// comment' instead of '#comment' or '//comment')
let g:NERDSpaceDelims = 1

" Always have Rainbow Parens enabled
let g:rainbow_active = 1

" use jk to exit insert mode
:imap jk <Esc>

" Buffer switching with tab
:nnoremap <Tab> :bnext<cr>
:nnoremap <S-Tab> :bprevious<cr>

" fold and unfold in normal mode with space. Fold in visual mode with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<cr>
vnoremap <Space> zf

" ; works just as well as : for normal mode! Saves hitting shift all the time
nnoremap ; :

" Airline related
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Session related
" Note that sessions won't be invoked if vim is started with arguments,
" including calling `vim .`
let g:prosession_on_startup=1 " start with last session if exists
let g:prosession_dir = '~/.vim_sessions'

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
map <Leader>rf :call RunCurrentSpecFile()<cr>
map <Leader>rc :call RunNearestSpec()<cr>
map <Leader>rl :call RunLastSpec()<cr>
map <Leader>rr :call RunAllSpecs()<cr>
map <Leader>rit :! bundle exec ruby spec/integration/integration.rb<cr>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e ~/.vimrc<cr>
nmap <silent> <leader>sv :so ~/.vimrc<cr>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
