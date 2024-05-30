local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'rebelot/kanagawa.nvim',
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gs", "<cmd>:0G<CR>")
        end
    },
    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },   
    { 
        'nvim-telescope/telescope.nvim', version = "0.1.4",
        dependencies = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require("telescope").setup({
                pickers = {
                    find_files = {
                        theme = "dropdown"
                    },
                    git_files = {
                        theme = "dropdown"
                    },
                    grep_string = {
                        theme = "dropdown"
                    }
                }

            })
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") } );
            end)
        end
    },   
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = { 
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        config = function()
            vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
        end
    },
    {
        "shortcuts/no-neck-pain.nvim", 
        version = "*",
        config = function()
            require('no-neck-pain').setup({
                mappings = {
                    toggle = "<Leader>nn",
                    enabled = true
                }
            })

        end
    },
    {
        'APZelos/blamer.nvim',
        config = function()
            vim.g.blamer_enabled = 1 
        end
    },
    {
        'airblade/vim-gitgutter',
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            vim.opt.list = true
            vim.opt.listchars:append "eol:↴"
            require('ibl').setup({})
        end
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate" -- :MasonUpdate updates registry contents
    },
    {
        'tpope/vim-surround',
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
      config = function()
          require('lualine').setup{
              options = {
                  icons_enabled = true,
                  theme = 'auto',
                  component_separators = { left = '', right = ''},
                  section_separators = { left = '', right = ''},
              }
          }
      end
    },
    {
        'epwalsh/obsidian.nvim',
        version = "*",
        ft = "markdown",
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('obsidian').setup({

                workspaces = {
                    {
                        name = "Second Brain",
                        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Second Brain"
                    }
                },
                completion = {
                    nvim_cmp = true,
                    min_chars = 2,

                },
                notes_subdir = "0 Inbox",
                new_notes_location = "notes_subdir",
                note_id_func = function(title)
                    return title
                end,
                note_frontmatter_func = function(note)
                    return {}
                end,
                templates = {
                    subdir = "003 Templates",
                    date_format = "%Y%m%d",
                    time_format = "%H%M",
                }
            })

            vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
              'williamboman/mason.nvim',
          },
          {'williamboman/mason-lspconfig.nvim'}, -- Optional
          -- Autocompletion
          {'hrsh7th/nvim-cmp'},     -- Required
          {'hrsh7th/cmp-nvim-lsp'}, -- Required
          {'L3MON4D3/LuaSnip'},     -- Required
      },
      config = function()
          local lsp = require('lsp-zero').preset({})

          lsp.ensure_installed({
              'tsserver',
              'eslint',
              'lua_ls'
          })


          local cmp = require('cmp')
          local cmp_select = { behaviour = cmp.SelectBehavior.Select }
          local cmp_mappings = lsp.defaults.cmp_mappings({
              ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
              ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
              ['<C-y>'] = cmp.mapping.confirm({ select = true }),
              ['<C-Space>'] = cmp.mapping.complete(),
          })

          lsp.setup_nvim_cmp({
              mapping = cmp_mappings
          })

          lsp.on_attach(function(client, bufnr)
              lsp.default_keymaps({buffer = bufnr})
          end)

          -- (Optional) Configure lua language server for neovim
          require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

          lsp.setup()
      end 
  }
})
