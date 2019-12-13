" vim: set et fenc=utf-8 ff=unix sts=8 sw=4 ts=4 
" " initialize basic settings
"
set nocompatible


filetype plugin indent on
syntax on
set number

set autoindent
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround
set backspace=indent,eol,start

set cursorline
set report=0

set wildignore=*.swp,*.bak,*.pyc,*.obj,*.o,*.class
set vb

set splitbelow
set splitright

set pyxversion=3

" ===
" auto install plug
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.config/nvim/plugged')
        Plug 'mhinz/vim-startify'
        Plug 'tpope/vim-fugitive'
        Plug 'mbbill/undotree'
        Plug 'scrooloose/nerdcommenter'
        Plug 'jaxbot/semantic-highlight.vim'
        Plug 'chrisbra/Colorizer'
        Plug 'fatih/vim-go'
        "Plug 'morhetz/gruvbox'
        Plug 'ajmwagar/vim-deus'
        "Plug 'dracula/vim', { 'as': 'dracula' }
        Plug 'Yggdroot/LeaderF'
        Plug 'w0rp/ale'
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'Shougo/unite.vim'
        Plug 'Shougo/vimfiler.vim'
        " Snippets
        Plug 'SirVer/ultisnips'
        Plug 'honza/vim-snippets'
        if has('nvim')
                Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemote'}
                Plug 'Shougo/defx.nvim', {'do': ':UpdateRemotePlugins'}
        else
                Plug 'Shougo/deoplete.nvim'
                Plug 'Shougo/defx.nvim'
                Plug 'roxma/nvim-yarp'
                Plug 'roxma/vim-hug-neovim-rpc'
        endif

        Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
        Plug 'deoplete-plugins/deoplete-jedi'
call plug#end()


" ===
" dress up my vim 
" ===
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
color deus
hi Normal guibg=none
"color gruvbox
"let g:gruvbox_contrast_dark = 'soft'
"colorscheme dracula
"set background=dark


" ===
" deoplete config
" ===
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
" 用户输入至少两个字符时再开始提示补全
call deoplete#custom#source('LanguageClient',
            \ 'min_pattern_length',
            \ 2)
" 字符串中不补全
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['String']
            \ )
" 补全结束或离开插入模式时，关闭预览窗口
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-tab> pumvisible() ? "\<c-p>" : "\<tab>"

" let g:deoplete#sources#jedi#python_path = 'python'

" ===
" LeaderF config
" ===
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.40
let g:Lf_CacheDirectory = expand('~/.config/nvim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" ===
" ale config
" ===
"let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_airline#extensions#ale#enabled = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_fix_on_save = 1
let g:ale_linters = {
            \   'python': ['flake8'],
            \}
let g:ale_fixers = {
            \   'python': ['autopep8', 'isort'],
            \}


" ===
" airline config
" ===
let g:airline_powerline_fonts = 1 
let g:airline_theme = 'powerlineish'

" VimFiler config
"
let g:vimfiler_as_defualt_explorer = 1
noremap <c-e> :VimFilerSplit -winwidth=35 -toggle -simple -no-quit<cr>

" ===
" vim-go config
" ===
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4


" ===
" === Undotree
" ===
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1


" ===
" === Colorizer
" ===
autocmd BufNewFile,BufRead *.css,*.html,*.htm  :ColorHighlight!


" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "
" noremap ; :

" Save & quit
noremap <LEADER>q :q<CR>
noremap <LEADER>s :w<CR>
"
" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" Open Startify
noremap <LEADER>st :Startify<CR>

" system clipboard
noremap <C-c> "+y
"noremap <C-v> "+gp


noremap <LEADER>t :LeaderfFunction<CR>

noremap <LEADER>u :UndotreeToggle<CR>
" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l


" ===
" === Terminal Behavior
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert

noremap <LEADER>/ :term<CR>
tnoremap <Esc> <C-\><C-n>

" ===
" === call CompileRunGcc
" ===
nnoremap <Leader>r :call CompileRunGcc()<CR>

func! CompileRunGcc()
    if &filetype == 'python'
        set splitbelow
        :sp
        :term time python %
    elseif &filetype == 'go'
        set splitbelow
        :sp
        :term time go run %
    endif
endfunc
