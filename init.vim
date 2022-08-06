" Indent
set autoindent
set expandtab
filetype indent on
set shiftround
set shiftwidth=2
set smarttab
set tabstop=2

" Search
set hlsearch
set ignorecase
set incsearch
set smartcase

" Performance
set complete-=i
set lazyredraw

" Text Rendering
set display+=lastline
set encoding=utf-8
set linebreak
set scrolloff=1
set sidescrolloff=5
syntax on
set wrap

" User Interface
set laststatus=2
set ruler
set wildmenu
set tabpagemax=50
set cursorline
set number
" set relativenumber
set noerrorbells
set visualbell
set mouse=a
set title
set cmdheight=1
set signcolumn=number

" Folding
set nofoldenable

" Clipboard
set clipboard+=unnamedplus

" Others
set autoread
set backspace=indent,eol,start
set confirm
set formatoptions+=j
set hidden
set history=1000
set nomodeline
set noshowmode
set noswapfile
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c

if has('termguicolors')
  set termguicolors
endif

" Key mapping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

vnoremap > >gv
vnoremap < <gv

" Plugins
call plug#begin('~/.config/nvim/plugged')

" Language
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Icon
Plug 'kyazdani42/nvim-web-devicons'

" Status bar
Plug 'nvim-lualine/lualine.nvim'

" Tabs bar
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

" Nerd tree
Plug 'kyazdani42/nvim-tree.lua'

" Theme
Plug 'sainnhe/everforest'

" Indent
" Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'zivyangll/git-blame.vim'
Plug 'tpope/vim-fugitive'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'windwp/nvim-ts-autotag'
Plug 'windwp/nvim-autopairs'

" Search
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
Plug 'junegunn/fzf.vim'

" Comment
Plug 'b3nj5m1n/kommentary'

" Surrounding
Plug 'tpope/vim-surround'

" Multicursor
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Snippets
Plug 'honza/vim-snippets'
Plug 'mlaursen/vim-react-snippets'

" Repeat
Plug 'tpope/vim-repeat'

call plug#end()

let g:everforest_background = 'soft'
let g:everforest_better_performance = 1

" Theme
set background=dark

colorscheme everforest
" hi Normal guibg=none ctermbg=none

" Tree
:lua require('tree')

" Treesitter
:lua require('treesitter')

" Indent
:lua require('indent')

" Tree
nnoremap <C-n> :NvimTreeToggle<CR>

" StatusLine
:lua require('statusline')

" Tabs Line
:lua require('tabline')
nnoremap <silent>[b :BufferLineCycleNext<CR>
nnoremap <silent>]b :BufferLineCyclePrev<CR>

" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>

" Git blame
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" Telescope

" :lua require('finder')

" nnoremap <C-p> <cmd>Telescope find_files hidden=true no_ignore=true<cr>
" nnoremap <C-f> <cmd>Telescope live_grep hidden=true no_ignore=true<cr>
" nnoremap <C-p> <cmd>Telescope find_files<cr>
" nnoremap <C-f> <cmd>Telescope live_grep<cr>

" FZF preview window
let g:fzf_preview_window = ['up:40%']
" FZF
nnoremap <C-p> :FZF!<CR>
" Ripgrep
nnoremap <C-f> :Rg!<CR>
" Ripgrep file content only
command! -bang -nargs=* RG
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
" nnoremap <C-x> :RG!<CR>

" commenter
:lua require('comment')

" Multicursor
" let g:VM_maps = {}
" let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
" let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n
" let g:VM_mouse_mappings = 1

" Auto pairs
:lua require('autopairs')

" Coc.nvim
" Coc Extensions
let g:coc_global_extensions = [
  \ 'coc-spell-checker',
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-emmet',
  \ 'coc-css',
  \ 'coc-styled-components',
  \ 'coc-python',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-vetur',
  \ 'coc-docker',
  \ 'coc-emoji',
  \ 'coc-tailwindcss',
  \ ]

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"

" remap for complete to use tab and <cr>
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-cursor)
nmap <leader>a  <Plug>(coc-codeaction-cursor)

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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

" Coc snippets
" Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<C-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<C-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
" xmap <leader>x  <Plug>(coc-convert-snippet)
