autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
autocmd BufWritePost source %

function! ToggleCursorLine()
    if (bufname("%") =~ "NerdTree")
        setlocal cursorline
    else
        setlocal nocursorline
    endif
endfunction

call plug#begin(stdpath('config').'/plugged')
	Plug 'folke/which-key.nvim' " show keys mapping
  Plug 'romgrk/barbar.nvim' " tabline plugin (buffers)
  Plug 'glepnir/dashboard-nvim' " dashboard
  Plug 'nvim-lua/plenary.nvim' " utils
	Plug 'nvim-lualine/lualine.nvim' " lualine
	Plug 'kyazdani42/nvim-web-devicons' " icons

  Plug 'nvim-lua/plenary.nvim' " window maganment

	Plug 'RishabhRD/popfix' " popup fix
  Plug 'nvim-lua/popup.nvim' " popup implementation
	Plug 'RishabhRD/nvim-lsputils' 

	Plug 'junegunn/vim-easy-align' " align text
  Plug 'caenrique/nvim-toggle-terminal' " terminal
  Plug 'justinmk/vim-sneak'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'nvim-treesitter/nvim-treesitter' " treesitter interface
  Plug 'unblevable/quick-scope' " highlight f t
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'tpope/vim-surround' " mappings to change surroundings
  Plug 'tpope/vim-unimpaired' " usefull binds: clear nlines, toggling options, decoding encoding
  Plug 'mattn/emmet-vim'
  Plug 'windwp/nvim-autopairs'
  Plug 'mhinz/vim-signify' " vcs (git, svn...) highlight
	Plug 'f-person/git-blame.nvim' 
  Plug 'folke/trouble.nvim'
	" Latex
  Plug 'lervag/vimtex'

  " Nerdtree
  Plug 'preservim/nerdtree'
	Plug 'preservim/nerdcommenter'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'PhilRunninger/nerdtree-visual-selection'
	Plug 'ryanoasis/vim-devicons'

  " COC
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " COLORS
  Plug 'ulwlu/abyss.vim'
  Plug 'projekt0n/github-nvim-theme'
  Plug 'morhetz/gruvbox'
  Plug 'kaicataldo/material.vim'
  Plug 'ayu-theme/ayu-vim'
  Plug 'rakr/vim-one', {'frozen': 1}
  Plug 'NTBBloodbath/doom-one.nvim'
  Plug 'real-99/onedarker.nvim'
  Plug 'catppuccin/nvim', {'as': 'catppuccin'}

call plug#end()

let g:mapleader = " "
let g:maplocalleader = ','

" STANDARD SETTINGS
" natural split settings
set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99

" Code Editor settings
filetype plugin on

" Core settings
syntax on
set nu 
set ruler
set hidden " textedit might fail if not set
set showcmd
set autoread
set noswapfile " doesn't create swap files
set noshowmode
set scrolloff=7
set sidescrolloff=7
set shortmess+=c
set encoding=utf-8
set number relativenumber
set clipboard+=unnamedplus " public copy/paste register
set omnifunc=syntaxcomplete#Complete

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

" true colors
if !has('gui_running')
  set t_Co=256
endif
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
" if (has("termguicolors"))
"   set termguicolors
" endif

" remap plugs for 
imap <C-Space> <C-x><C-o>

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

" wraps
:set wrap
:set textwidth=0
nnoremap <buffer><localleader>w :set wrap!<cr>

" save remaps
nnoremap <leader>W :w !diff % -<cr>
nnoremap <leader>w :w<cr>

" buffer settings
nnoremap <tab> :bn<return>
nnoremap <s-tab> :bp<return>
nnoremap <silent><leader>d :bp\|bd #\|BarbarEnable<return>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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

"split navigations
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>

" terminal switch
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

"split resize arrows
nnoremap <C-UP> :resize -2<CR>
nnoremap <C-Down> :resize +2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" --- NAVIGATION ---
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>
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

" VimTeX vimtex
filetype plugin indent on
" syntax enable
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" let g:vimtex_view_general_options_latexmk = '--unique'
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

"COC START
" Some servers have issues with backup files, see #649 (coc).
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" PYDOC
nmap <silent> <leader>ca <Plug>(coc-codeaction-line)
xmap <silent> <leader>ca <Plug>(coc-codeaction-selected)
nmap <silent> <leader>cA <Plug>(coc-codeaction)
" Use K to sho<leader>caw documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
nmap <A-S-f> :call CocActionAsync('format')<CR>
nmap <A-S-i> :CocCommand editor.action.organizeImport<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" popup
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)
" echo
" nmap <Leader>e <Plug>(coc-translator-e)
" vmap <Leader>e <Plug>(coc-translator-ev)
" replace
nmap <Leader>r <Plug>(coc-translator-r)
vmap <Leader>r <Plug>(coc-translator-rv)

" replace result on current expression
nmap <Leader>cr <Plug>(coc-calc-result-replace)

" --------
" FIX CURSOR DISAPPEAR AFTER :CocList
let g:coc_disable_transparent_cursor = 1
" --------

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <Tab> and <S-Tab> to navigate the completion list:
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" COC GIT
" nmap [g <Plug>(coc-git-prevchunk)
" nmap ]g <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

"COC END

lua<<EOF
require('nvim-autopairs').setup{}
require("trouble").setup{}
require("which-key").setup {
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
}
EOF

let g:github_function_style = "italic"
let g:github_sidebars = ["qf", "vista_kind", "terminal", "packer"]

" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:github_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }


set timeoutlen=500

" Load the colorscheme
" abyss
" ayu
" gruvbox
" one
" onedarker
" material
" catppuccin
" github_dark
colorscheme gruvbox

autocmd CursorHold * silent call CocActionAsync('highlight')

" init.vim quick edits
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" codeforces splits
nnoremap <leader>cfi :split in.txt<CR>
nnoremap <leader>cfo :vsplit out.txt<CR>

nnoremap <silent> <C-z> :ToggleTerminal<Enter>
tnoremap <silent> <C-z> <C-\><C-n>:ToggleTerminal<Enter>

let g:python3_host_prog = "/usr/bin/python3.8"
