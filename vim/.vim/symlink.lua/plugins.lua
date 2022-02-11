vim.g.USE_PLUGINS = 1
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use {
    'neovim/nvim-lspconfig', -- Collection of configurations for the built-in LSP client
    'williamboman/nvim-lsp-installer' -- Auto-install LSP providers to `stdpath('data')`
  }
  use 'j-hui/fidget.nvim' -- Progress indicator for LSP
  use 'hrsh7th/cmp-nvim-lsp-signature-help' -- Show function signatures while typing
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-path' -- Path based-completion
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'rafamadriz/friendly-snippets' -- Snippets source

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/playground'
  use 'p00f/nvim-ts-rainbow'
  use 'romgrk/nvim-treesitter-context'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  use  'liuchengxu/vista.vim'

  use 'jeetsukumaran/vim-filebeagle' -- File Explorer Plugin

  use 'junegunn/fzf' -- Fuzzy file finder
  use 'junegunn/fzf.vim'

  use { -- Comment engine
    'kkoomen/vim-doge',
    run = ':call doge#install()'
  }

  use 'qpkorr/vim-bufkill' -- Close buffers without closing windows

  use 'tomtom/tcomment_vim' -- Comment motions

  use 'windwp/nvim-autopairs' -- Auto-close ',",[,(, etc

  use 'AdnoC/vim-ninja-feet' -- Allows splitting text object into before and after cursor motions

  use 'kana/vim-operator-user' -- Custom operators
  use 'kana/vim-textobj-user' -- Custom text objects
  use 'rhysd/vim-operator-surround' -- Surround operators

  use 'tpope/vim-repeat' -- repeat plugin actions

  use 'AdnoC/vim-bufsurf' -- MRU buffer navigation per-tab
  use 'sainnhe/sonokai' -- Colorscheme

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)


-- LSP setup
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local remap_opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', remap_opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', remap_opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', remap_opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', remap_opts)
vim.api.nvim_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', remap_opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', remap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', remap_opts)
end

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = {}
    opts.on_attach = on_attach
    opts.flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
    if server.name == 'sumneko_lua' then
      opts.settings = {
          Lua = {
              diagnostics = {
                  globals = { 'vim' }
              }
          }
      }
    end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

require"fidget".setup {}

-- nvim-cmp setup

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip.loaders.from_vscode").load()

-- nvim-cmp setup
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = "nvim_lsp_signature_help" },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-- treesitter setup
require 'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  rainbow = {
    enable = true,
    disable = { 'bash' }
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enabled = true },
  refactor = {
    highlight_definitions = { enable = false }
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aC'] = '@class.outer',
        ['iC'] = '@class.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['ae'] = '@block.outer',
        ['ie'] = '@block.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['is'] = '@statement.inner',
        ['as'] = '@statement.outer',
        ['ad'] = '@comment.outer',
        ['am'] = '@call.outer',
        ['im'] = '@call.inner',
      }
    }
  }
}

-- vista
vim.g.vista_close_on_jump=1
vim.g.vista_default_executive = 'nvim_lsp'
vim.g.vista_finder_alternative_executives = { 'ctags' }
vim.api.nvim_set_keymap('n', '<leader>cb', ':Vista<CR>', remap_opts)

-- Operator surround
vim.api.nvim_set_keymap('', 'sa', '<Plug>(operator-surround-append)', { silent= true })
vim.api.nvim_set_keymap('', 'sd', '<Plug>(operator-surround-delete)', { silent= true })
vim.api.nvim_set_keymap('', 'sc', '<Plug>(operator-surround-replace)', { silent= true })

-- bufsurf
vim.api.nvim_set_keymap('n', ']b', '<Plug>(buf-surf-forward)', { silent= true })
vim.api.nvim_set_keymap('n', '[b', '<Plug>(buf-surf-back)', { silent= true })

-- fzf
vim.g.fzf_command_prefix = 'Fzf'
vim.api.nvim_set_keymap('n', '<leader>p', ':FZF<CR>', remap_opts);
vim.api.nvim_set_keymap('n', '<leader>b', ':FzfBuffers<CR>', remap_opts);

--doge
vim.g.doge_doc_standard_python = "python"
vim.g.doge_mapping_comment_jump_forward = "<c-j>"
vim.g.doge_mapping_comment_jump_backward = "<c-k>"

-- Autoparis
require('nvim-autopairs').setup {}
cmp.event:on('confirm_done',
  require('nvim-autopairs.completion.cmp').on_confirm_done({  map_char = { tex = '' } }))


-- bufkill
vim.g.BufKillCreateMappings=0

-- sonokai setup
vim.g.sonokai_style = 'andromeda'
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_disable_italic_comment = 1
