-- utilities
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- terminal options
vim.api.nvim_exec([[
  set t_ZH=^\[\[3m
  set t_ZR=^\[\[23m
  let &t_ut=''
]], false)

-- default save options
vim.o.hidden = true
vim.o.encoding = 'utf8'

-- scroll and mouse options
vim.o.mouse = vim.o.mouse .. 'a'
vim.o.scrolloff = 2

-- indentation options
vim.o.autoindent = true
vim.o.smartindent = false
vim.o.breakindent = true

-- default tab options
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- tweak redraw timings
vim.o.lazyredraw = true
vim.o.updatetime = 500

-- show matching brackets
vim.o.showmatch = true

-- fold options
vim.o.foldenable = true
vim.o.foldmethod = 'indent'
vim.o.foldnestmax = 9
vim.o.foldlevelstart = 3

-- search options
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.inccommand = 'nosplit'

-- status options
vim.o.laststatus = 2
vim.o.statusline = '%F%m%r%h%w [%l,%c] [%L,%p%%]'

-- disable backups and swaps
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- no completion or startup messages
vim.o.shortmess = vim.o.shortmess .. 'cI'

-- line numbers
vim.wo.number = true

-- splitting options
vim.go.splitbelow = true
vim.go.splitright = true

-- undo history
local undodir = vim.fn.expand('$HOME') .. '/.cache/nvim/undo'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end

vim.o.undodir = undodir
vim.o.undofile = true
vim.o.undolevels = 1000
vim.o.undoreload = 10000

-- display options
vim.o.wrap = false
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.cmdheight = 1
vim.o.background = 'dark'
vim.wo.signcolumn = 'yes'
vim.wo.cursorline = true
vim.cmd('colorscheme theme')

-- misc. options
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.backspace = 'indent,eol,start'

-- polyglot
vim.g.javascript_plugin_flow = 1
vim.g.jsx_ext_required = 0
vim.g.vim_markdown_fenced_languages = { 'jsx=javascript', 'js=javascript', 'ts=typescript', 'bash=sh' }
vim.g.vim_markdown_json_frontmatter = 1

-- unmap special keys
local key_opt = { noremap = true, silent = true }
vim.api.nvim_set_keymap('', '<Space>', '<nop>', key_opt)
vim.api.nvim_set_keymap('', '<F1>', '<nop>', key_opt)
vim.api.nvim_set_keymap('i', '<F1>', '<nop>', key_opt)
vim.api.nvim_set_keymap('n', '<Up>', '<nop>', key_opt)
vim.api.nvim_set_keymap('n', '<Down>', '<nop>', key_opt)
vim.api.nvim_set_keymap('n', '<Left>', '<nop>', key_opt)
vim.api.nvim_set_keymap('n', '<Right>', '<nop>', key_opt)

-- period command in visual mode
vim.api.nvim_set_keymap('x', '.', ':norm.<CR>', key_opt)

-- match ctrl-c to escape
vim.api.nvim_set_keymap('', '<c-c>', '<ESC>', key_opt)
vim.api.nvim_set_keymap('!', '<c-c>', '<ESC>', key_opt)

-- window controls
vim.api.nvim_set_keymap('', '<c-w>,', ':vsp<CR>', key_opt)
vim.api.nvim_set_keymap('', '<c-w>.', ':sp<CR>', key_opt)

-- remap semicolon to colon
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })

-- destructive x-commands
vim.api.nvim_set_keymap('', 'X', '"_d', key_opt)
vim.api.nvim_set_keymap('n', 'XX', '"_dd', key_opt)
vim.api.nvim_set_keymap('v', 'x', '"_d', key_opt)
vim.api.nvim_set_keymap('n', 'x', 'v"_d', key_opt)

-- clipboard controls
vim.api.nvim_set_keymap('x', 'Y', '"+y', key_opt)
vim.api.nvim_set_keymap('x', '<M-c>', '"+y', key_opt)
vim.api.nvim_set_keymap('x', '<M-v>', '"+p', key_opt)
vim.api.nvim_set_keymap('n', '<M-v>', '"+P', key_opt)

-- indentation in visual mode
vim.api.nvim_set_keymap('v', '<', '<gv', key_opt)
vim.api.nvim_set_keymap('v', '>', '>gv', key_opt)

-- pum tabbing
function _G.smart_tab()
  return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end

function _G.s_smart_tab()
  return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<S-Tab>'
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_smart_tab()', { expr = true, noremap = true })

-- macros per line
vim.api.nvim_set_keymap('v', '@', ':<C-u>execute ":\'<,\'>normal @".nr2char(getchar())<CR>', key_opt)

-- fold controls
vim.api.nvim_set_keymap('n', '<bar>', ':<C-u>normal zc<CR>', key_opt)
vim.api.nvim_set_keymap('n', '<bslash>', ':<C-u>normal za<CR>', key_opt)

-- set space as leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- buffer shortcuts
vim.api.nvim_set_keymap('n', '<Leader>h', ':bprevious<CR>', key_opt)
vim.api.nvim_set_keymap('n', '<Leader>h', ':bnext<CR>', key_opt)
vim.api.nvim_set_keymap('n', '<Leader>j', '<c-^>', key_opt)
vim.api.nvim_set_keymap('n', '<Leader>k', ':bp <BAR> bd #<CR>', key_opt)

-- defx
vim.api.nvim_set_keymap('n', '-', ":Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>", key_opt)

-- hop
require('hop').setup({ teasing = false })

vim.api.nvim_set_keymap('', '<Up>', "<cmd>lua require('hop').hint_lines_skip_whitespace({ direction = 1 })<CR>", key_opt)
vim.api.nvim_set_keymap('', '<Down>', "<cmd>lua require('hop').hint_lines_skip_whitespace({ direction = 2 })<CR>", key_opt)
vim.api.nvim_set_keymap('', '<Left>', "<cmd>lua require('hop').hint_words({ direction = 1 })<CR>", key_opt)
vim.api.nvim_set_keymap('', '<Right>', "<cmd>lua require('hop').hint_words({ direction = 2 })<CR>", key_opt)

-- telescope
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      nix_bins.ripgrep,
      '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
    },
    prompt_prefix = '→ ',
    selection_caret = '→ ',
  },
}

vim.api.nvim_set_keymap('n', '<Leader>q', "<cmd>lua require('telescope.builtin').quickfix()<CR>", key_opt)
vim.api.nvim_set_keymap('n', '<Leader>p', "<cmd>lua require('telescope.builtin').loclist()<CR>", key_opt)
vim.api.nvim_set_keymap('n', '<Leader>o', "<cmd>lua require('telescope.builtin').git_files()<CR>", key_opt)
vim.api.nvim_set_keymap('n', '<Leader>f', "<cmd>lua require('telescope.builtin').live_grep()<CR>", key_opt)
vim.api.nvim_set_keymap('n', '<Leader>n', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", key_opt)
vim.api.nvim_set_keymap('n', '<Leader>b', "<cmd>lua require('telescope.builtin').buffers()<CR>", key_opt)

-- callback for LSP init
local on_attach = function(client, buf)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(buf, ...) end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(buf, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', key_opt)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', key_opt)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', key_opt)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', key_opt)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', key_opt)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', key_opt)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', key_opt)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', key_opt)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', key_opt)
end

-- lsp signs
vim.fn.sign_define("LspDiagnosticsErrorSign", { text = "●", texthl = "LspDiagnosticsError" })
vim.fn.sign_define("LspDiagnosticsWarningSign", { text = "◐", texthl = "LspDiagnosticsWarning" })

-- lspconfig
local lsp = require('lspconfig')
local lsp_util = require('lspconfig/util')

require('lspconfig/configs').prosemd = {
  default_config = {
    cmd = { "/Users/phil/Development/prosemd-lsp/target/release/prosemd-lsp", "--stdio" },
    filetypes = { "markdown" },
    root_dir = function(fname)
      return lsp_util.find_git_ancestor(fname) or vim.fn.getcwd()
    end,
    settings = {},
  }
}

lsp.prosemd.setup {
  on_attach = on_attach
}

lsp.tsserver.setup {
  on_attach = on_attach,
  cmd = { nix_bins.tsserver, "--stdio" }
}

lsp.vimls.setup {
  on_attach = on_attach,
  cmd = { nix_bins.vimls, "--stdio" }
}

lsp.rls.setup {
  on_attach = on_attach,
  cmd = { nix_bins.rls }
}

lsp.terraformls.setup {
  on_attach = on_attach,
  cmd = { nix_bins.tfls }
}

-- treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "typescript", "tsx", "graphql", "regex", "json", "javascript", "jsdoc", "css", "rust" },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "]",
      scope_incremental = "=",
      node_decremental = "[",
    },
  },
  refactor = {
    highlight_definitions = { enable = true },
    smart_rename = { enable = true, keymaps = { smart_rename = "gn" } },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@call.outer",
        ["ic"] = "@call.inner",
      },
    },
  },
}

-- defx settings
vim.api.nvim_exec([[
  function! DefxSettings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ defx#do_action('open')
    nnoremap <silent><buffer><expr> -
    \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> h
    \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> l
    \ defx#do_action('open')
    nnoremap <silent><buffer><expr> <CR>
    \ defx#do_action('open')
    nnoremap <silent><buffer><expr> K
    \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N
    \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> r
    \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
    \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> q
    \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
    \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> j
    \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
    \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> cd
    \ defx#do_action('change_vim_cwd')
  endfunction

  function! DefxOpen()
    try
      let l:dir = expand(expand('%:p'))
    catch
      return
    endtry

    if !empty(l:dir) && (isdirectory(l:dir) ||
      \ (!empty($SYSTEMDRIVE) && isdirectory('/'.tolower($SYSTEMDRIVE[0]).l:dir)))
      execute "Defx `expand('%:p')` | bd " . expand('%:r')
    endif
  endfunction

  function! CursorHoldDelay(timer)
    if mode() ==# 'n'
      echon ''
    endif
  endfunction

  autocmd FileType defx call DefxSettings()
  autocmd VimEnter * sil! au! FileExplorer *
  autocmd BufEnter * call DefxOpen()
  autocmd CursorHold * call timer_start(3000, funcref('CursorHoldDelay'))
]], false)

-- completion
require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 3,
  preselect = 'enable',
  throttle_time = 100,
  source_timeout = 200,
  resolve_timeout = 800,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' },
    winhighlight = 'NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder',
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  },
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
  },
}

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'ayu_mirage',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}
