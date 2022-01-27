" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
autocmd BufWritePost source %
" PLUGINS
call plug#begin(stdpath('config').'/plugged')
  " CMP
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
	Plug 'RishabhRD/popfix'
	Plug 'RishabhRD/nvim-lsputils'
  " LSP
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'rafamadriz/friendly-snippets'

	" Keep lsp hover while typing
	Plug 'ray-x/lsp_signature.nvim'

  " COLORS
  Plug 'morhetz/gruvbox'
  Plug 'kaicataldo/material.vim'
  Plug 'ayu-theme/ayu-vim'
  Plug 'lunarvim/darkplus.nvim'
	Plug 'NTBBloodbath/doom-one.nvim'
  Plug 'mhartington/oceanic-next'
  Plug 'navarasu/onedark.nvim'
	Plug 'real-99/onedarker.nvim'

  " BUFFERS
  Plug 'romgrk/barbar.nvim'

  " LOOKS
  Plug 'glepnir/dashboard-nvim'

  " FUNCTIONAL 
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'tpope/vim-ragtag'
  Plug 'justinmk/vim-sneak'
  Plug 'tpope/vim-surround'
  Plug 'lervag/vimtex'
  Plug 'tpope/vim-unimpaired'
  Plug 'mattn/emmet-vim'

  Plug 'preservim/nerdtree'
	Plug 'preservim/nerdcommenter'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'PhilRunninger/nerdtree-visual-selection'
	Plug 'ryanoasis/vim-devicons'
  Plug 'windwp/nvim-autopairs'
  Plug 'mhinz/vim-signify'
	Plug 'f-person/git-blame.nvim'

	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'unblevable/quick-scope'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'folke/trouble.nvim'
  Plug 'habamax/vim-godot'
  Plug 'mxw/vim-jsx'

" Initialize plugin system
call plug#end()

" KEYBINDINGS
" leaders
let g:mapleader = " "
let g:maplocalleader = ','

let g:airline_powerline_fonts = 1

" TROUBLE trouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" >> Telescope bindings
nnoremap <Leader>pp <cmd>lua require'telescope.builtin'.builtin{}<CR>

" most recently used files
nnoremap <Leader>m <cmd>lua require'telescope.builtin'.oldfiles{}<CR>

" find buffer
nnoremap <Leader>; <cmd>lua require'telescope.builtin'.buffers{}<CR>

" find in current buffer
nnoremap <Leader>/ <cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>

" bookmarks
nnoremap <Leader>' <cmd>lua require'telescope.builtin'.marks{}<CR>

" git files
nnoremap <Leader>f <cmd>lua require'telescope.builtin'.git_files{}<CR>

" all files
nnoremap <Leader>bfs <cmd>lua require'telescope.builtin'.find_files{}<CR>

" ripgrep like grep through dir
nnoremap <Leader>rg <cmd>lua require'telescope.builtin'.live_grep{}<CR>

" pick color scheme
nnoremap <Leader>ce <cmd>lua require'telescope.builtin'.colorscheme{}<CR>

" remap plugs for 
imap <C-Space> <C-x><C-o>

"split navigations
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>

"split resize arrows
nnoremap <C-UP> :resize -2<CR>
nnoremap <C-Down> :resize +2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

"move lines arrows
nnoremap <A-down> :m .+1<CR>==
nnoremap <A-up> :m .-2<CR>==
vnoremap <A-down> :m '>+1<CR>gv=gv
vnoremap <A-up> :m '<-2<CR>gv=gv
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" clear highlight
nnoremap <leader>m :noh<return>
nno <BS> :set hls!\|set hls?<CR>

"Surround selected text
vnoremap ;' <ESC>`<i'<ESC>`>la'<ESC>`<lv`>l
vnoremap ;" <ESC>`<i"<ESC>`>la"<ESC>`<lv`>l
vnoremap ;{ <ESC>`<i{<ESC>`>la}<ESC>`<lv`>l
vnoremap ;( <ESC>`<i(<ESC>`>la)<ESC>`<lv`>l
vnoremap ;[ <ESC>`<i[<ESC>`>la]<ESC>`<lv`>l
vnoremap ;$ <ESC>`<i$<ESC>`>la$<ESC>`<lv`>l

" init.vim quick edits
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" show colors
nnoremap <leader>c :so $VIMRUNTIME/syntax/hitest.vim<return>
:set wrap
:set textwidth=0
:set colorcolumn=80

nnoremap <buffer><localleader>w :set wrap!<cr>

" save remaps
nnoremap <leader>W :w !diff % -<cr>
nnoremap <leader>w :w<cr>

" buffer settings
nnoremap <s-tab> :bp<return>
nnoremap <tab> :bn<return>
nnoremap <silent><leader>d :bp\|bd #\|BarbarEnable<return>

" VimTeX vimtex
filetype plugin indent on
syntax enable
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_complete_enabled = 1
let g:vimtex_complete_auto = 1
let g:Tex_IgnoredWarnings = 0
let g:vimtex_quickfix_ignore_filters = [
      \'Underfull \\hbox (badness [0-9]*) in paragraph at lines',
      \'Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines',
      \'Underfull \\hbox (badness [0-9]*) in ',
      \'Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in ',
      \'Package hyperref Warning: Token not allowed in a PDF string',
      \'Package typearea Warning: Bad type area settings!',
      \]

" STANDARD SETTINGS

" natural split settings
set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99

" Code Editor settings
filetype plugin on
" set tabstop=4
" set softtabstop=0
" set expandtab
" set shiftwidth=4
" set smarttab

" Core settings
syntax on
set nu 
set ruler
set hidden
set showcmd
set noswapfile " doesn't create swap files
set noshowmode
set scrolloff=7
set sidescrolloff=7
set shortmess+=c
set encoding=UTF-8
set number relativenumber
set clipboard+=unnamedplus " public copy/paste register
set omnifunc=syntaxcomplete#Complete

" set completeopt to have a better completion experience
set completeopt=menu,menuone,noselect

" Indentation and mouse
set backspace=indent,eol,start " let backspace delete over lines
set autoindent
set smartindent " allow vim to best-effort guess the indentation
set mouse+=a

" Searching
set ignorecase
set smartcase
set wildmenu "graphical auto complete menu

set lazyredraw "redraws the screne when it needs to
set showmatch "highlights matching brackets
set incsearch "search as characters are entered

"customm
"autocmd BufEnter * silent! lcd %:p:h

" RICING

" true colours
if !has('gui_running')
  set t_Co=256
endif
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

" doom-one
" ayu
" set background=dark
colorscheme onedarker

" TELESCOPE
nnoremap <silent><C-P> :Telescope find_files<cr>

" --- NAVIGATION ---
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '>,*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

let g:nerdtree_vis_confirm_open = 0
let g:nerdtree_vis_confirm_delete = 1
let g:nerdtree_vis_confirm_copy = 1
let g:nerdtree_vis_confirm_move = 1

map <space>cs <plug>NERDCommenterSexy
map <space>ci <plug>NERDCommenterInvert
map <space>cu <plug>NERDCommenterUncomment
map <leader>cl <plug>NERDCommenterAlignLeft
map <leader>cb <plug>NERDCommenterAlignBoth

" lua settings
" cursorline
autocmd! BufEnter * call ToggleCursorLine()
 
" BARBAR 
let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:true
let bufferline.animation = v:true
let bufferline.no_name_title = "untitled"

" QUICK SCOPE
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
nnoremap <silent> <leader>c} V}:call NERDComment('x', 'toggle')<CR>
nnoremap <silent> <leader>c{ V{:call NERDComment('x', 'toggle')<CR>

" SNEAK 
" global
let g:sneak#prompt = '  '
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1
let g:sneak#label = 1
" highlights
highlight Sneak guifg=white guibg=#708be6 ctermfg=black ctermbg=red gui=none
highlight SneakScope guifg=black guibg=#49A3ff ctermfg=red ctermbg=yellow gui=italic

let g:godot_executable = '/home/maxim/src/godot/godot'

lua << EOF
-- SETUPS setups
require('nvim-autopairs').setup{}

--completion = {
--	autocomplete = true
--},
-- CMP, cmp setting
require("luasnip.loaders.from_vscode").lazy_load({
	paths = { "./my-snippets" }
})
require("luasnip.loaders.from_vscode").lazy_load({})
local cmp = require 'cmp'
cmp.setup ({
	snippet = {
		expand = function(args)
		require('luasnip').lsp_expand(args.body)
	end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(), ['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-j>'] = cmp.mapping.scroll_docs(4),
		['<C-Space'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm ({
		behavior = cmp.ConfirmBehavior.Replace,
		select = true,
		}),
	['<Tab>'] = function(fallback)
	if cmp and cmp.visible() then
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
		'<C-n>', true, true, true), 'm')
	elseif require('luasnip').expand_or_jumpable() then
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
		'<Plug>luasnip-expand-or-jump', true, true, true), '')
	else
		fallback()
	end
end,
['<S-Tab>'] = function(fallback)
if cmp and cmp.visible() then
	vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
	'<C-p>', true, true, true), 'm')
elseif luasnip.expand_or_jumpable(-1) then
	vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
	'<Plug>luasnip-jump-prev', true, true, true), '')
else
	fallback()
end
end,
},
  sources = {
    { name = 'path' },
		{ name = 'buffer' },
    { name = 'luasnip' },
    { name = 'nvim' },
    },
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
	})
})


-- LSP, lsp SETTINGS
--local nvim = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

	require "lsp_signature".on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded"
		}
	}, bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<A-S-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings({
ui = {
  icons = {
    server_installed = "✓",
    server_pending = "➜",
    server_uninstalled = "✗"
    }
  }
})

local enhance_server_opts = {
  -- Provide settings that should only apply to the "eslintls" server
  ["eslintls"] = function(opts)
    opts.settings = {
      format = {
        enable = true,
      },
    }
  end,
  ["hls"] = function(opts)
    opts.root_dir = dirname
  end,
  ["denols"] = function(opts)
    opts.init_options = {
			enable = true,
			lint = true
    }
  end,

  
}

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = on_attach
        }
  if enhance_server_opts[server.name] then
      enhance_server_opts[server.name](opts)
  end
  server:setup(opts)
end)


-- TROUBLE trouble
require("trouble").setup{}
require("lsp_signature").setup{
	doc_lines = 10,
	hint_prefix = "🐼 ",
	floating_window_above_cur_line = true,
}

EOF

" transparency TRANSPARENCY
":hi! Normal ctermbg=NONE guibg=NONE

"if has('termguicolors') && $TERM_PROGRAM ==# 'iTerm.app'
"  set t_8f=^[[38;2;%lu;%lu;%lum
"  set t_8b=^[[48;2;%lu;%lu;%lum
"  set termguicolors
"endif
