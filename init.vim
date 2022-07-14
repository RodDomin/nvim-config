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
 Plug 'jparise/vim-graphql'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'mkitt/tabline.vim'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'dracula/vim', { 'as': 'dracula' }
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
 Plug 'nvim-treesitter/nvim-treesitter-angular'
 Plug 'ThePrimeagen/vim-be-good'
 Plug 'cakebaker/scss-syntax.vim'
 Plug 'APZelos/blamer.nvim'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'antoinemadec/FixCursorHold.nvim'
 Plug 'nvim-neotest/neotest'
 Plug 'https://github.com/haydenmeade/neotest-jest'
 Plug 'https://github.com/neovim/nvim-lspconfig'
 Plug 'kyazdani42/nvim-web-devicons'
 Plug 'kyazdani42/nvim-tree.lua'
 Plug 'pianocomposer321/consolation.nvim'
call plug#end()

" airline
let g:airline_theme = 'dracula'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'

" neotest
nnoremap <A-t> :lua require("neotest").summary.toggle() <CR>
nnoremap <A-a> :lua require("neotest").run.run(vim.fn.expand("%")) <CR>
nnoremap <A-e> :lua require("neotest").run.run() <CR>
nnoremap <A-o> :lua require("neotest").output.open({ enter = true }) <CR>

lua <<EOF
require'plenary.async'
require("neotest").setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = "npm test --",
      jestConfigFile = "custom.jest.config.ts",
    }),
  },
})
EOF

" fzf
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

nnoremap <C-o> :Files <CR>
nnoremap <C-f> :Ag <CR>

" treesitter start script
lua <<EOF
require'plenary.async'
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript", "javascript" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { }, -- List of parsers to ignore installing
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

" nvim-tree
nnoremap <C-p> :NvimTreeToggle<CR>
nnoremap <C-c> :NvimTreeCollapse<CR>

lua <<EOF
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
EOF

" Coc
let g:coc_disable_startup_warning = 1

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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

" blamer
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
let g:blamer_prefix = ' > '

" consolation
" nnoremap <silent> te
nnoremap <silent> T :lua require('consolation'):new() <CR>
