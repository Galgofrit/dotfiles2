" General 
set number
syntax on
filetype plugin on 
filetype indent on 
set ignorecase
set smartcase
set nowrap

" Tab NOW SET BY AutoIndent
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4
let g:detectindent_preferred_tabstop = 4
" autocmd BufReadPost * :DetectIndent
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
autocmd filetype xml :DetectIndent

" Tags
set tags+="~/.vim/tags"
let g:ctags_statusline=1
let ctags_title=1

fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map f :call ShowFuncName() <CR>


set autoread " auto reload changed files
command W w !sudo tee % > /dev/null
set ruler
set incsearch
set lazyredraw
set magic
set showmatch

" Add full file path to statusline
set statusline+=%F
set laststatus=2

" Quick compilation shortcuts
autocmd filetype c nnoremap <F5> :w <bar> :Dispatch gcc *.c -o out; ./out<CR> 
autocmd filetype python nnoremap <F5> :w <bar> :Dispatch python %<CR>
autocmd filetype objc nnoremap <F5> :w <bar> :Dispatch clag -framework Foundation *.m  -o out; ./out%<CR>
" autocmd filetype python nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>
" autocmd filetype c nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o'.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
" autocmd filetype objc nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o'.shellescape('%:r').' && ./'.shellescape('%:r')<CR>

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Surround - use lowercase s to surround with 
vmap s S

" Merge clipboards with system's
set clipboard=unnamed

" Folding settings
" XML
augroup XML
    autocmd!
        autocmd FileType xml setlocal foldmethod=manual foldlevelstart=999 foldminlines=0
    augroup END


" " " " " " " " " " " "
" " PLUGIN SETTINGS " "
" " " " " " " " " " " "

" DelimitMate settings
let g:delimitMate_autoclose = 1
let g:delimitMate_matchpairs = "(:),[:],{:}"
autocmd filetype vim let delimitMate_smart_quotes = "':'" " vimrc uses \" for comments
autocmd FileType python let b:delimitMate_nesting_quotes = ["'", '"'] 
let g:delimitMate_jump_expansion = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_inside_quotes = 1


" NERDCommenter settings
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCommentEmptyLines = 1


" YouCompleteMe settings
" Doesn't work - fix this 
" autocmd FileType man let g:loaded_youcompleteme = 1
"
inoremap <C-c> <Esc>:pclose<CR><Esc>
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1 
let g:ycm_confirm_extra_conf = 0
" let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_objective_c'
" let g:ycm_global_ycm_extra_conf = '~/.vim/ycm.py'
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_extra_conf_vim_data   = ['&filetype']
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_complete_in_comments = 1
let g:ycm_auto_start_csharp_server = 0
let g:ycm_cache_omnifunc = 0
let g:ycm_auto_trigger = 1
" let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_semantic_triggers = {
 \ 'objc' : ['re!\@"\.*"\s',
 \ 're!\@\w+\.*\w*\s',
 \ 're!\@\(\w+\.*\w*\)\s',
 \ 're!\@\(\s*',
 \ 're!\@\[.*\]\s',
 \ 're!\@\[\s*',
 \ 're!\@\{.*\}\s',
 \ 're!\@\{\s*',
 \ "re!\@\’.*\’\s",
 \ '#ifdef ',
 \ 're!:\s*',
 \ 're!=\s*',
 \ 're!,\s*', ],
 \ }
autocmd filetype c nnoremap gd :YcmCompleter GoTo<CR>
map F :YcmCompleter FixIt<CR> " Apply YCM FixIt


" ale
" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" Enable completion where available.
let g:ale_completion_enabled = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8'],
\}
nmap <leader>f :ALEFix<cr>



" Jedi-vim
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 1


" Gutentags
let g:gutentags_modules = ['ctags', 'gtags_cscope']
" let g:gutentags_modules = ['ctags']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_project_root = ['.git', '.cproject', 'Makefile', '.xcodeproj']
let g:GtagsCscope_Auto_Map = 1
let g:GtagsCscope_Auto_Load = 1
let g:GtagsCscope_Quiet = 1
set statusline+=%{gutentags#statusline()}

" Gutentags for lightline
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END
" tags with lightline and tagbar
source ~/.vim/tagbar_showfunc.vim


" ale for lightline
let g:lightline = {}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }


" CtrlP
" Make ctrlp a lot faster in git repositories
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']
" let g:ctrlp_user_command = 'mdfind -onlyin %s file'
let g:ctrlp_use_caching = 1 " ag is so fast that caching isn’t necessary
let g:ctrlp_max_files = 10000
let g:ctrlp_working_path_mode = 'r' " Always use the current working directory rather than the location of the current file
let g:ctrlp_by_filename = 1 " Default to filename only search rather than searching the whole path.  This is more like Xcode's Shift+Cmd+O


" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$\|\.pyc$\|\.*.sw.'
  \ }


" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" nmap <leader>f <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1

" FuzzyFinder
map <F3> :FufFileWithFullCwd<CR>


" man on current word with m
nmap M <Plug>(Man)
" nmap m <Plug>(Vman) " Vertical

" vimplugged 
call plug#begin()
Plug 'Valloric/YouCompleteMe' " our lord and savior
Plug 'w0rp/ale' " async python analysis
Plug 'davidhalter/jedi-vim' " used mostly for refactor 
Plug 'tpope/vim-fugitive' " git wrapper

Plug 'scrooloose/nerdcommenter' " autocomment
Plug 'Raimondi/delimitMate' " auto add newline and }
Plug 'tpope/vim-surround' " support more surrounds
Plug 'tpope/vim-dispatch' " background tasks in vim
Plug 'tpope/vim-repeat'
Plug 'christoomey/vim-tmux-navigator' " integrate with tmux
Plug 'vim-scripts/L9' " required for other plugins
Plug 'vim-scripts/FuzzyFinder' " fuzzy file browser
Plug 'vim-utils/vim-man' " man pages in vim
Plug 'ciaranm/detectindent' " auto set indentation according to current file indentation

Plug 'easymotion/vim-easymotion' " quickly jump to letters
Plug 'vim-scripts/camelcasemotion' " ',w', ',b', ',e' to navigate camelcase
Plug 'itchyny/lightline.vim' " better status line
Plug 'maximbaz/lightline-ale' " ale plugin for lightline

Plug 'ludovicchabant/vim-gutentags' " auto generate tags for projects
Plug 'vim-scripts/gtags.vim' " support for GNU Gtags
Plug 'vim-scripts/ctags.vim' " support for ctags
Plug 'majutsushi/tagbar' " show tags in statusbard
Plug 'kien/ctrlp.vim' " quick search bar

Plug 'msanders/cocoa.vim' " objective c support
" Plug 'darfink/vim-plist' " add symantic support for plist files
call plug#end()
