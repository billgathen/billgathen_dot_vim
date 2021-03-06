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
" - http://janjiss.com/walkthrough-of-my-vimrc-file-for-ruby-development
"
" On OSX, use `brew install vim` to get version with clipboard enabled!

" Only works in gui versions of vim! (MacVim, etc)
" In terminal vim, control it with the terminal font (pastel dark works well)
colorscheme railscasts
set gfn=Source\ Code\ Pro:h12,Menlo:h12

set number
let mapleader=" "

set shiftwidth=2  "number of spaces to use in each autoindent step
set tabstop=2     "two tab spaces
set softtabstop=2 "number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab     "spaces instead of tabs for better cross-editor compatibility

set cindent       "recommended setting for automatic C-style indentation
set wrap
set linebreak     "wrap entire words, don't break them; much easier to read!

" Show trailing whitespace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" Make every cut/paste interact with system clipboard!
" No more " * p
set clipboard=unnamed

" Ben Orenstein - Write code faster: expert-level vim (Railsberry 2012) 
" https://youtu.be/SkdrYWhh-8s
" Saving and quitting are tedious
nmap <leader>s :w<cr>
nmap <leader>q :q<cr>
nmap <leader>qa :qall<cr>
nmap <leader>Q :wq<cr>
" Ben Tips
" :AV open the alternate rails file in a vertical split
" [m and ]M jump to the beginning/end of the current method

" Bram Moolenaar '7 Habits'
" * searches for the current word
" ctrl-n opens autocomplete, ctrl-n and p navigate it

" vimtutor tips
" u undoes the last change, U undoes all changes on the current line

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

" Vundle plugin manager help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" List bundles here
"
" After changes:
" :source %
" :PluginInstall
"
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'vim-ruby/vim-ruby'
Plugin 'mattn/emmet-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'pangloss/vim-javascript'
Plugin 'airblade/vim-gitgutter'
Plugin 'rking/ag.vim'
" Plugin 'bling/vim-airline'
Plugin 'janko-m/vim-test'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-classpath'
Plugin 'luochen1990/rainbow'
Plugin 'vim-syntastic/syntastic'
"End of bundles

call vundle#end()
filetype plugin indent on

" vim-commentary: But I WANT to use \\
:nmap \\ gc
:xmap \\ gc

" vim-ruby suggested options
set nocompatible
filetype off
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
nmap <silent> <leader>t :w<CR>:TestNearest<CR>
nmap <silent> <leader>T :w<CR>:TestFile<CR>
" nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>
" Dispatch opens in temp window, then opens quickfix list
" if any errors result. :cn and :cp navigate through the errors,
" jumping you directly to the spec files they occurred in!
" let test#strategy = 'dispatch'

" rails.vim
" :A (alternate file)
" gf (edit file containing the object under the cursor)
" :Rpreview (open this project in a browser: knows about POW!)
" :help rails (to view the help)

map <Leader>r :! clear; ruby %<CR>

" JavaScript Development
" https://medium.com/@hpux/vim-and-eslint-16fa08cc580f
" Syntastic + ESLint
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'

map <Leader>j :! node %<CR>
