set tabstop=4
set shiftwidth=4
set noexpandtab
filetype off
syntax on
set enc=utf-8
" Spell Checker, disabled by default.
set spelllang=en_nz
set nospell
" clipboard
set clipboard=unnamed

" show control characters tabs/trailing spaces/EOL
" :set nolist to turn it off
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" Colour Rules.
" I also like to use ubuntu mono as my terminal font.
set background=dark
if &term =~ '256color'
	" disable background color eraser (BCE) so that color schemes
	" render properly inside 256-color tmux and GNU Screen.
	set t_ut=
endif
colorscheme delek
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#0000ff
highlight BadWhitespace ctermbg=red guibg=darkred

let python_highlight_all=1
let c_highlight_all=1
set nocompatible " be ViMproved
set whichwrap=b,s,<,>,[,]
set ruler
set backspace=indent,eol,start

" Enable folding
set foldmethod=indent
set foldlevel=99

" switch between splits with ctrl + <>
" ctrl + J = down
" ctrl + K = up ?
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding with the spacebar
nnoremap <space> za

" vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle "lepture/vim-jinja"
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
Plugin 'csexton/snipmate.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'jnurmine/Zenburn'
Plugin 'elixir-lang/vim-elixir'
Plugin 'ledger/vim-ledger'
call vundle#end()

" Syntastic settings
" use :SyntasticToggleMode
" to turn off
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_yaml_checkers = ['yamllint']
" other options include pylint and pyflakes
let g:syntastic_python_checkers = ['flake8', 'python']
" seems to use python3 builtins by default. add py2 builtins as well.
let g:syntastic_python_flake8_args = '--builtins=execfile,raw_input,basestring'


" YCM settings
let g:ycm_path_to_python_interpreter = 'python2'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"let g:dbext_default_profile_PG = 'type=PGSQL:user=postgres'
let g:SimpylFold_docstring_preview=1

let NERDTreeIgnore=['\.pyc$', '\~$']

set omnifunc=csscomplete#CompleteCSS
" .py rules. FIXME does this need to match ..pyw/etc as well?
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
" html/css/js
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab
" white space rules
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" Ledger Formatting
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
" Ruby formatting
au Filetype ruby setlocal shiftwidth=2 tabstop=2 expandtab
" git Commit 
autocmd Filetype gitcommit setlocal spell textwidth=72

" Tab Rules
" shift+pgUp/pgDown to change tabs.
nnoremap <S-PageUp> :tabprevious<CR>
nnoremap <S-PageDown> :tabnext<CR>

" special code for mrimpossible using tabs in python files
function! SetupEnvironment()
	let l:path = expand('%:p')
	if l:path =~ '/home/callum/work/mrimpossible'
		setlocal ts=4 sw=4 sts=4 textwidth=79 fileformat=unix autoindent noet
		let g:syntastic_mode_map = { 'mode': 'passive' }
	endif
endfunction
autocmd! BufReadPost,BufNewFile *.py call SetupEnvironment()


" python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

