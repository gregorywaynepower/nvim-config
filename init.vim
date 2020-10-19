call plug#begin("~/.config/nvim/plug-config")
  " Plugin Section
  "Syntax Highlighting for All Languages
  Plug 'sheerun/vim-polyglot'
	" Airling Plugin - this has caused launch to be a smidge slower.
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'	
	" File Explorer with Icons
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'ryanoasis/vim-devicons'
  "vimwiki Plugin https://github.com/vimwiki/vimwiki
  Plug 'vimwiki/vimwiki'
  " File Search
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  "Switch Between Projects https://github.com/benwainwright/fzf-project
  Plug 'benwainwright/fzf-project'
  "Dependency for FZF Project, also a great Git Plugin
  Plug 'tpope/vim-fugitive'
	"Git Gutter Plugin - this also takes a second to launch the gutter.
	Plug 'airblade/vim-gitgutter'
	"Ranger Plugin for File Browsing https://github.com/francoiscabrol/ranger.vim
	Plug 'francoiscabrol/ranger.vim'
	"Dependency for Ranger
	Plug 'rbgrouleff/bclose.vim'
	""Auto Pairs https://github.com/jiangmiao/auto-pairs
	"Autocompletes brackets
	Plug 'jiangmiao/auto-pairs'
	"Surround Package Vim
	Plug 'tpope/vim-surround'
	" Language Client
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-python']
call plug#end()

"----------------------------------------------------------------------
" Configuration Options
"----------------------------------------------------------------------

" Add convenience variable for powerline-fonts
let g:airline_powerline_fonts = 1

"----------------------------------------------------------------------
" Basic Options
"----------------------------------------------------------------------

" The <leader> key
let mapleader=" " 
set colorcolumn=80

" Now, to search for a file, press Ctrl+P , search for the file you’re looking for, and press:
"   CTRL+T to open it in a new tab.
"   CTRL+S to open below (split view).
"   CTRL+T to open to the side (vertical split).
"   Enter to open it in the currently selected panel.

nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" requires silversearcher-ag
" used to ignore gitignore files
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" open new split panes to right and below
set splitright
set splitbelow

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

"Prerequisites for Vimwiki
set nocompatible
filetype plugin on
syntax on

" open terminal on ctrl+n
" uses zsh instead of bash
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" use system clipboard by default formatted to work on multiple platforms
set clipboard^=unnamed,unnamedplus

" enable mouse support
set mouse=a

" setting relative line numbers and line numbers on the side to appear
set number
set relativenumber

" stop cursor keys in normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" better indenting in visual mode with < >
vnoremap < <gv
vnoremap > >gv

if exists('g:vscode')

  " don't highlight search items
  set nohlsearch

  " call VSCodeCommentary on the visual selection, and then re-select that visual selection with gv
  xmap <C-/> <Plug>VSCodeCommentarygv
  nmap <C-/> <Plug>VSCodeCommentaryLine

else

  let g:codedark_conservative = 1
  colorscheme codedark

  " converts tabs to spaces
  set expandtab
  " insert 2 spaces for a tab
  set tabstop=2
  " number of space characters inserted for indentation
  set shiftwidth=2
  " wrap at word boundaries rather than right at the terminal edge
  set linebreak
  " change terminal title to name of file
  set title
  " set spell checking language
  set nospell spelllang=en_us

  " toggle spell checking in normal and insert mode
  nnoremap <silent> <F6> :set invspell<cr>
  inoremap <silent> <F6> <C-O>:set invspell<cr>

  " toggle buffers
  nnoremap <Tab> :bnext<CR>
  nnoremap <S-Tab> :bprevious<CR>

  " esc to turn off search highlighting
  nnoremap <silent> <esc> :noh<cr>

  " disable accidentally pressing ctrl-z and suspending 
  nnoremap <c-z> <Nop>

  let g:markdown_fenced_languages = ['bash=sh', 'javascript', 'js=javascript', 'json=javascript', 'typescript', 'ts=typescript', 'php', 'html', 'css']

endif
