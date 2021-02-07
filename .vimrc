set ts=4 sw=4 sts=4 fileformat=unix autoindent et
setlocal ts=4 sw=4 sts=4 fileformat=unix autoindent et
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
colorscheme offdelek
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
" Plugin 'marijnh/tern_for_vim'
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
 Plugin 'mbbill/undotree'
 " dart syntax highlighting
 Plugin 'dart-lang/dart-vim-plugin'
 " Valloric, HTML Tag matching
 Plugin 'valloric/MatchTagAlways'
 " SEARCH!
 Plugin 'junegunn/fzf'
 Plugin 'junegunn/fzf.vim'
 " RST highlighting
 Plugin 'Rykka/riv.vim'

 " Auto Create Doc Strings in Python.
 " ctrl + i
 Plugin 'heavenshell/vim-pydocstring'

 " DB Ext
 Plugin 'vim-scripts/dbext.vim'
 " TypeScript highlighting?
 Plugin 'leafgarland/typescript-vim'
 Plugin 'peitalin/vim-jsx-typescript'
 Plugin 'maxmellon/vim-jsx-pretty'
 " Toml highlighting
 Plugin 'cespare/vim-toml'
 Plugin 'vmchale/tomlcheck-vim'
 " Fluent Highlighting
 Plugin 'projectfluent/fluent.vim'
call vundle#end()
filetype plugin indent on


"call plug#begin('~/.local/share/nvim/plugged')
" reasonml support
" language server 1
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
" (Optional) Multi-entry selection UI.
" Plugin 'junegunn/fzf'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'roxma/vim-hug-neovim-rpc'
"Plug 'roxma/nvim-yarp'
" language server 2
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" reasonml
"Plug 'reasonml-editor/vim-reason-plus'
"Plug 'w0rp/ale'

"call plug#end()

" DISABLE ALE BY DEFAULT
" It's not as good as Syntastic.
let g:ale_enabled = 0

" RST highlights in python:
let g:riv_python_rst_hl=1

" Syntastic settings
" use :SyntasticToggleMode
" to turn off
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_debug = 3
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" JS Linter
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['eslint']
" YAML Linter
let g:syntastic_yaml_checkers = ['yamllint']
" other options include pylint and pyflakes
" let g:syntastic_python_checkers = ['flake8', 'mypy', 'python']
let g:syntastic_python_checkers = ['flake8', 'python']
" let g:syntastic_python_checkers = ['mypy', 'flake8', 'python']
" seems to use python3 builtins by default. add py2 builtins as well.
let g:syntastic_python_flake8_args = '--benchmark --max-line-length=90 --ignore=W191,W503'
" ShellCheck should follow `source` calls in the script.
let g:syntastic_sh_shellcheck_args = '-x'
let g:syntastic_python_mypy_args = '--ignore-missing-imports --no-strict-optional --cache-dir /home/callum/work/.mypy_mrimpossible/'
" Custom Checker for PLPGSQL
let g:syntastic_sql_checkers = ['sqlfluff', 'pgsanity']

" Syntastic Key Bindings
map <leader>q :lnext<CR>

" YCM settings
let g:ycm_python_binry_path = '/usr/bin/python3'
let g:ycm_path_to_python_interpreter = '/usr/bin/python3'
" let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_log_level='debug'
let g:ycm_autoclose_preview_window_after_completion=1
" YCM Key Bindings
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>gt :tab split<CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>
map <leader>h  :YcmCompleter GetDoc<CR>
map <leader>f  :YcmCompleter FixIt<CR>
" re-compile.
nnoremap <F6> :YcmDiags<CR>


let g:dbext_default_profile_PG = 'type=PGSQL:user=callum:host=localhost:dbname=g_windriverfitness:port=5432'
autocmd VimEnter * DBCompleteTables


let g:SimpylFold_docstring_preview=1

let NERDTreeIgnore=['\.pyc$', '\~$']


" set omnifunc=csscomplete#CompleteCSS
au BufNewFile,BufRead *.py,*.pyw
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" html/css/js
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab


" white space rules
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.ftl match BadWhitespace /\s\+$/
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


" Undo Tree commands
nnoremap <F5> :UndotreeToggle<cr>
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif


" python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  if sys.version_info.major != 3:
    execfile(activate_this, dict(__file__=activate_this))
  else:
    exec(open(activate_this).read(), dict(__file__=activate_this))
EOF

au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm,*.jinja set ft=jinja


" special code for mrimpossible using tabs in python files
function! SetupPyEnvironment()
	let l:path = expand('%:p')
	if l:path =~ '/home/callum/work/mrimpossible'
		let g:dbext_default_profile = 'PG'
		set textwidth=89 ts=4 sw=4 sts=4 fileformat=unix autoindent noet
		setlocal textwidth=89 ts=4 sw=4 sts=4 fileformat=unix autoindent noet
		let g:syntastic_python_flake8_args = '--benchmark --max-line-length=90 --builtins=execfile,raw_input,basestring'
		let g:ycm_python_binry_path = '/usr/bin/python3'
		let g:syntastic_python_python_exec = '/usr/bin/python3'
		let g:ycm_path_to_python_interpreter = 'python3'
		" let g:syntastic_mode_map = { 'mode': 'passive' }
	endif
endfunction
autocmd! BufReadPost,BufNewFile *.py call SetupPyEnvironment()


function! SetupJsEnvironment()
	let l:path = expand('%:p')
	if l:path =~ '/home/callum/work/mrimpossible'
		setlocal ts=2 sw=2 sts=2 fileformat=unix autoindent et
		set ts=2 sw=2 sts=2 fileformat=unix autoindent et
	endif
endfunction
autocmd! BufReadPost,BufNewFile *.js,*.jsx,*.html call SetupJsEnvironment()

function! SetupSQLEnvironment()
	let l:path = expand('%:p')
	if l:path =~ '/home/callum/work/mrimpossible'
		let g:dbext_default_profile = 'PG'
		let g:syntastic_sql_checkers = ['sqlfluff', 'pgsanity']
		setlocal ts=4 sw=4 sts=2 fileformat=unix autoindent noet
		set ts=4 sw=4 sts=4 fileformat=unix autoindent noet
	endif
endfunction
autocmd! BufReadPost,BufNewFile *.sql call SetupSQLEnvironment()

" Type Script Files.
let g:ycm_always_populate_location_list = 1
au BufRead,BufNewFile *.ts,*.tsx set ts=4 sw=4 sts=4 noet ft=typescript textwidth=79
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx textwidth=79

" TOML
au BufRead,BufNewFile *.toml set ts=4 sw=4 sts=4 et list ft=toml
" let g:ycm_filetype_specific_completion_to_disable = {"typescript": 1}

au BufRead,BufNewFile *.ftl set ts=4 sw=4 sts=4 fileformat=unix autoindent et ft=fluent
