call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'AndrewRadev/sideways.vim'
Plug 'jpalardy/vim-slime'
Plug 'rebelot/kanagawa.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'connorholyday/vim-snazzy'
Plug 'dracula/vim'
Plug 'Konfekt/FastFold'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ray-x/lsp_signature.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'liuchengxu/vista.vim'
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'catppuccin/nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/seoul256.vim'
Plug 'numToStr/Comment.nvim'
Plug 'tomtom/tlib_vim'
Plug 'markonm/traces.vim'
Plug 'tpope/vim-abolish'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'romainl/vim-cool'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/vim-easy-align'
Plug 'dag/vim-fish'
Plug 'romainl/vim-qf'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-rooter'
Plug 'connorholyday/vim-snazzy'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-python/python-syntax'
Plug 'kana/vim-textobj-user'
Plug 'bps/vim-textobj-python'
Plug 'fladson/vim-kitty'
Plug 'liuchengxu/vista.vim'
Plug 'rust-lang/rust.vim'
Plug 'projekt0n/github-nvim-theme'
Plug 'ionide/Ionide-vim'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""
" Editor Configuration

syntax on                      " Syntax highlighting
filetype plugin on             " Load ftplugins
set wildmenu                   " Show options for Ex commands
" set nocompatible
set backspace=indent,eol,start " Backspace over everything
set clipboard=unnamed          " Use system keyboard
set incsearch                  " Incremental search
set hidden                     " Keep persistent terminal
set hlsearch                   " Stop highlighting searches
set encoding=UTF-8             " Set encoding (useful for correctly displaying icons)
set shiftwidth=4               " 4-space indentations
set expandtab                  " Expand tabs to spaces
set noswapfile                 " Don't use swap files
set noerrorbells               " No error bells
set vb t_vb=                   " No visual errors
set undofile                   " Maintain undo history for each file
set undodir=~/.vim/undodir     " Directory in which to store undo files
set ic scs                     " case insensitive search with case-sensitive completion
set autowrite                  " Autosave contents of buffer on make among other things
set autoindent                 " Automatically copy indentation from the previous line
set ruler                      " Show location in file at the bottom
set nobackup                   " Don't create backups of files that are being edited
set nowritebackup              " Same as above
set confirm                    " Ask before performing destructive operations
set ch=2                       " Increase height of command
set ls=2                       " Always have status line (use universal status line)
set termguicolors              " Needed to make the colorschemes work
set undofile                   " Persistent undo
set cmdheight=2                " More space for displaying messages
set updatetime=300             " decrease lag
set shortmess+=c               " Don't pass messages to |ins-completion-menu|. 
set signcolumn=yes             " Always show the sign column (avoids jarring effect)

" A good set of defaults for all languages
set expandtab shiftwidth=4 tabstop=4 softtabstop=4

colo kanagawa
set bg=dark
hi MatchParen ctermbg=blue guibg=lightblue

let &t_ut=''      " Background erase workaround (see https://sw.kovidgoyal.net/kitty/faq.html#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim)
" nnoremap <SPACE> <nop>
let mapleader="<SPACE>"
let $RTP='/Users/vigsivan/.config/vim/.vim/' " Set vim config path
" let g:context_enabled = 1
let g:do_filetype_lua = 1  " Detect filetype in Lua (faster)


""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xnoremap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nnoremap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal
tnoremap <ESC> <C-\><C-n>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickfix

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <SPACE>q <nop>
nnoremap <silent> <SPACE>qq :call ToggleQuickFix()<cr>
nnoremap <silent> <SPACE>qh :cc<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Status Line

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" set statusline=%f%m%r%h\ [%L]\ %{NearestMethodOrFunction()}

""""""""""""""""""""""""""""""""""""""""""""""""""
" Telescope (Slower but prettier than FZF)

nnoremap <SPACE>f <nop>
nnoremap <SPACE>. <cmd>Telescope find_files<cr>

" Find files using Telescope command-line sugar.
nnoremap <SPACE>ff <cmd>Telescope find_files<cr>
nnoremap <SPACE>fg <cmd>Telescope live_grep<cr>
nnoremap <SPACE>fb <cmd>Telescope buffers<cr>
nnoremap <SPACE>b <cmd>Telescope buffers<cr>
nnoremap <SPACE>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <SPACE>fh <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <SPACE>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <SPACE>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <SPACE>fb <cmd>lua require('telescope.builtin').buffers()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""
" traces
let g:traces_abolish_integration = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
" Slime
let g:slime_python_ipython = 1
let g:slime_target = "neovim"

nnoremap <C-c>j :SlimeSendCurrentLine<CR>j
nnoremap <C-c>} <C-c><C-c>}
nnoremap <C-c>i gg/import<C-c><C-c>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Sideways
nnoremap ]s :SidewaysRight<CR>
nnoremap [s :SidewaysLeft<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight Python

let g:python_highlight_all = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
" rooter
let g:rooter_silent_chdir = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw
let g:netrw_localrmdir='rm -r' " Use this command to delete stuff

""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <SPACE><SPACE> :call CocAction('diagnosticToggle')<CR>
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> gn <Plug>(coc-rename)

function! FloatScroll(forward) abort
  let float = coc#util#get_float()
  if !float | return '' | endif
  let buf = nvim_win_get_buf(float)
  let buf_height = nvim_buf_line_count(buf)
  let win_height = nvim_win_get_height(float)
  if buf_height < win_height | return '' | endif
  let pos = nvim_win_get_cursor(float)
  if a:forward
    if pos[0] == 1
      let pos[0] += 3 * win_height / 4
    elseif pos[0] + win_height / 2 + 1 < buf_height
      let pos[0] += win_height / 2 + 1
    else
      let pos[0] = buf_height
    endif
  else
    if pos[0] == buf_height
      let pos[0] -= 3 * win_height / 4
    elseif pos[0] - win_height / 2 + 1  > 1
      let pos[0] -= win_height / 2 + 1
    else
      let pos[0] = 1
    endif
  endif
  call nvim_win_set_cursor(float, pos)
  return ''
endfunction

inoremap <silent><expr> <down> coc#util#has_float() ? FloatScroll(1) : "\<down>"
inoremap <silent><expr>  <up>  coc#util#has_float() ? FloatScroll(0) :  "\<up>"

""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous keybindings

nnoremap <C-L> :%s/

""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure Lua plugins

lua << EOF

-- Git signs

require('gitsigns').setup()

-- Comment plugin

require('Comment').setup()

-- Telescope

local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
            },
        },
    },
})

-- Treesitter
-- require'treesitter-context'.setup()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "javascript", "python", "typescript", "vue", "css" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

EOF
