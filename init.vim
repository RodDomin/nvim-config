set number
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set termguicolors
set encoding=UTF-8
set background=dark
set mouse=a
syntax on

call plug#begin('~/.vim/plugged')
 Plug 'pangloss/vim-javascript'  
 Plug 'jparise/vim-graphql'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'preservim/nerdtree' 
 Plug 'Xuyuanp/nerdtree-git-plugin'
 Plug 'mkitt/tabline.vim'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'dracula/vim', { 'as': 'dracula' }
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
 Plug 'vim-test/vim-test'
 Plug 'https://github.com/rcarriga/vim-ultest.git'
 Plug 'tomasiser/vim-code-dark'
 Plug 'rescript-lang/vim-rescript'
call plug#end()

" airline
let g:airline_theme = 'dracula'

" vim ul test
let test#javascript#jest#options = "--color=always"
let g:ultest_running_sign = '🔄'
nnoremap <A-t> :UltestSummary <CR>
nnoremap <A-r> :Ultest <CR>
nnoremap <A-e> :UltestNearest <CR>
nnoremap <A-o> :UltestOutput <CR>

" fzf
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

nnoremap <C-o> :Files <CR>
nnoremap <C-f> :Ag <CR>

" treesitter start script
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
}
EOF

colorscheme dracula

" vim tabs
nnoremap <C-z> :tabprevious<CR>
nnoremap <C-x> :tabnext<CR>

" nerdtree
nnoremap <C-p> :NERDTreeToggle<CR>

let g:NERDTreeWinSize = 50
let g:NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Coc
let g:coc_disable_startup_warning = 1

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent> K :call <SID>show_documentation()<CR>

" moving lines
nnoremap <A-up> :m .-2<CR>
nnoremap <A-down> :m .+1<CR>

tnoremap <Esc> <C-\><C-n>

vnoremap <silent><Leader>y "yy <Bar> :call system('xclip', @y)<CR>

