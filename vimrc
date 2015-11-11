" CHECK THIS DIRECTORY INTO GITHUB!
"
" MY GLOBAL MARKS: (set using mV, mC, etc)
"   'V  # this file (~/.vimrc)
"   'C  # my cheat sheets (~/.vim/cheats.txt)
"   'M  # executable MiniTest cheat sheet (~/.vim/minitest_cheat.rb)
"   :source % # reloads this file after changes
"   :PluginInstall # installs all Vundle plugins
"
" GB: Gary Bernhardt from his Peepcode Play-By-Play
" Ben: Ben Orenstein
" PV: Practical Vim
" SB: Stephen Bach http://items.sjbach.com/319/configuring-vim-right
"
" Great vim resources:
" - http://vimsheet.com
" - http://vim.rtorr.com
"
" On OSX, use `brew install vim` to get version with clipboard enabled!

colorscheme railscasts
" Only works in gui versions of vim! (MacVim, etc)
" In terminal vim, control it with the terminal font
set gfn=Source\ Code\ Pro:h12,Menlo:h12

set number
let mapleader=" "

set shiftwidth=2  "number of spaces to use in each autoindent step
set tabstop=2     "two tab spaces
set softtabstop=2 "number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab     "spaces instead of tabs for better cross-editor compatibility

set autoindent    "keep the indent when creating a new line
set smarttab      "use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set cindent       "recommended seting for automatic C-style indentation
set wrap
set linebreak     "wrap entire words, don't break them; much easier to read!
set laststatus=2  "show status line
set incsearch     "show partial matches while typing
set backspace=indent,eol,start "allow backspacing over existing text


" GB: Highlight current line
set cursorline

" GB: Optimize search
" Highlight all occurrences of search term
set hls
" Center window on next/prev search result
:nnoremap N Nzz
:nnoremap n nzz
" Clear highlighting by pressing ENTER
:nnoremap <CR> :nohlsearch<CR>/<BS>

" toggle between last buffers
nnoremap <leader><leader> <c-^>

" Setting up Vundle - the vim plugin bundler
" http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#begin()
    Plugin 'gmarik/Vundle.vim'

    "List bundles here
    Plugin 'vim-ruby/vim-ruby'
    Plugin 'mattn/emmet-vim'
    Plugin 'kien/ctrlp.vim'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-bundler'
    Plugin 'tpope/vim-endwise'
    Plugin 'elixir-lang/vim-elixir'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'pangloss/vim-javascript'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'rking/ag.vim'
    Plugin 'bling/vim-airline'
    Plugin 'lambdatoast/elm.vim'
    Plugin 'janko-m/vim-test'
    Plugin 'tpope/vim-dispatch'
    Plugin 'tpope/vim-rails'
    "End of bundles
    "
    " After adding a new bundle, run:
    "
    " :source %
    " :PluginInstall
    "

    call vundle#end()
    filetype plugin indent on

    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" Setting up Vundle - the vim plugin bundler end

" vim-commentary: But I WANT to use \\
:nmap \\ gc
:xmap \\ gc

" vim-ruby suggested options
set nocompatible
syntax on
filetype on
filetype indent on
filetype plugin on
compiler ruby

" Keymaps
" Move between splits with <c-hjkl>"
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" File finder
set wildignore+=*.swp,*.log,node_modules,app/components

" SB: Store temp files in central location. Make sure to mkdir ~/.vim-tmp first!
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set visualbell "flash the screen instead of that annoying 'plonk!'

" PV: Tip 72 -- Only use case-sensitive if a capital letter is included
set ignorecase
set smartcase

" PV: Tip 109 -- Customize grep
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

" vim-test setup
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
" Dispatch opens in temp window, then opens quickfix list
" if any errors result. :cn and :cp navigate through the errors,
" jumping you directly to the spec files they occurred in!
let test#strategy = 'dispatch'

" rails.vim
" :A (alternate file)
" gf (edit file containing the object under the cursor)
" :Rpreview (open this project in a browser: knows about POW!)
" :help rails (to view the help)

map <Leader>r :! clear; ruby %<CR>
map <Leader>n :! clear; node %<CR>
map <Leader>e :! clear; elixir %<CR>
map <Leader>i :! clear; iex -S mix<CR>

" Elm Development
nmap mm :! elm-make Main.elm<cr>
