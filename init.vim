call plug#begin('~/.nvim/plugged')
Plug 'mbbill/undotree'
Plug 'junegunn/vim-easy-align'
Plug 'AndrewRadev/sideways.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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
Plug 'nvim-lua/plenary.nvim'
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
Plug 'joshdick/onedark.vim'
Plug 'ionide/Ionide-vim'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'tpope/vim-fugitive'

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
let g:codi#log="/Users/vigsivan/codi.log"

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
" Open mini terminal

let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <SPACE>' :call TermToggle(12)<CR>
tnoremap <SPACE>' :call TermToggle(12)<CR>
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

nnoremap <silent> <SPACE>g <nop>
" nnoremap <silent> <SPACE>gs :SignifyToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Fuzzy Finder

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <SPACE>. :Files<CR>

nnoremap <SPACE>f <nop>
nnoremap <SPACE>h <nop>

nnoremap <SPACE>ff :GitFiles<CR>
nnoremap <SPACE>fh :History<CR>
nnoremap <SPACE>fg :RG<CR>
nnoremap <SPACE>hh :Helptags<CR>
nnoremap <SPACE>b :Buffers<CR>

if has("nvim")
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
endif

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
"
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
nnoremap <silent>gn <Plug>(coc-rename)

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

nnoremap <C-L> :CocList symbols<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure Lua plugins

lua << EOF

-- Git signs

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('gitsigns').setup()

-- Comment plugin

require('Comment').setup()


-- Lualine plugin
-- require('lualine').setup()

-- Treesitter
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
