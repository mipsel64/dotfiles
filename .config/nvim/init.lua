-- always set leader first!
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-------------------------------------------------------------------------------
--
-- preferences
--
-------------------------------------------------------------------------------
-- never ever folding
vim.opt.foldenable = false
vim.opt.foldmethod = "manual"
vim.opt.foldlevelstart = 99
-- very basic "continue indent" mode (autoindent) is always on in neovim
-- could try smartindent/cindent, but meh.
-- vim.opt.cindent = true
-- XXX
-- vim.opt.cmdheight = 2
-- vim.opt.completeopt = 'menuone,noinsert,noselect'
-- not setting updatedtime because I use K to manually trigger hover effects
-- and lowering it also changes how frequently files are written to swap.
-- vim.opt.updatetime = 300
-- if key combos seem to be "lagging"
-- http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
-- vim.opt.timeoutlen = 300
-- keep more context on screen while scrolling
vim.opt.scrolloff = 2
-- enable wrap lines
vim.opt.wrap = true
-- always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.signcolumn = "yes"
-- sweet sweet relative line numbers
vim.opt.relativenumber = true
-- and show the absolute line number for the current line
vim.opt.number = true
-- keep current content top + left when splitting
vim.opt.splitright = true
vim.opt.splitbelow = true
-- infinite undo!
-- NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true
--" Decent wildmenu
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
vim.opt.wildmode = "list:longest"
-- when opening a file with a command (like :e),
-- don't suggest files like there:
vim.opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site"
-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true
-- never ever make my terminal beep
vim.opt.vb = true
-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append "iwhite"
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append "algorithm:histogram"
vim.opt.diffopt:append "indent-heuristic"
-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = "80"
--- except in Rust where the rule is 100 characters
vim.api.nvim_create_autocmd("Filetype", { pattern = "rust", command = "set colorcolumn=100" })
-- show more hidden characters
-- also, show tabs nicer
vim.opt.list = true
vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"

-- prevent override buffer to system clipboard
vim.opt.clipboard = ""

-- Use Ctrl+c to copy system clipboard
vim.keymap.set("v", "<C-c>", "\"+y<CR>", { desc = "Copy selected text to system clipboard" })

-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

-- highlight cursorline
vim.opt.cursorline = true

-- indent settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.bo.softtabstop = 4
vim.opt.expandtab = true

-- Shift left/right selected lines
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Shift selected line(s) to the right" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Shift selected line(s) to the left" })

-- Move lines up/down

vim.keymap.set("v", "<A-Down>", ":m'>+<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<A-Up>", ":m-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("i", "<A-Down>", "<Esc>:m+<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<A-Up>", "<Esc>:m-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("n", "<A-Down>", ":m+<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-Up>", ":m-2<CR>==", { desc = "Move line up" })


-- vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vim.keymap.set("v", "<C-r>", "\"hy:%s/<C-r>h//gc<left><left><left>", { desc = "Replace all selected text" })

-------------------------------------------------------------------------------
--
-- hotkeys
--
-------------------------------------------------------------------------------
-- quick-open
vim.keymap.set("", "<C-p>", "<cmd>Files<cr>")
-- search buffers
vim.keymap.set("n", "<leader>;", "<cmd>Buffers<cr>")
-- quick-save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
-- make missing : less annoying
vim.keymap.set("n", ";", ":")

-- Ctrl+j and Ctrl+k as Esc
vim.keymap.set("n", "<C-j>", "<Esc>")
vim.keymap.set("i", "<C-j>", "<Esc>")
vim.keymap.set("v", "<C-j>", "<Esc>")
vim.keymap.set("s", "<C-j>", "<Esc>")
vim.keymap.set("x", "<C-j>", "<Esc>")
vim.keymap.set("c", "<C-j>", "<Esc>")
vim.keymap.set("o", "<C-j>", "<Esc>")
vim.keymap.set("l", "<C-j>", "<Esc>")
vim.keymap.set("t", "<C-j>", "<Esc>")
-- Ctrl-j is a little awkward unfortunately:
-- https://github.com/neovim/neovim/issues/5916
-- So we also map Ctrl+k
vim.keymap.set("n", "<C-k>", "<Esc>")
vim.keymap.set("i", "<C-k>", "<Esc>")
vim.keymap.set("v", "<C-k>", "<Esc>")
vim.keymap.set("s", "<C-k>", "<Esc>")
vim.keymap.set("x", "<C-k>", "<Esc>")
vim.keymap.set("c", "<C-k>", "<Esc>")
vim.keymap.set("o", "<C-k>", "<Esc>")
vim.keymap.set("l", "<C-k>", "<Esc>")
vim.keymap.set("t", "<C-k>", "<Esc>")
-- Esc to stop searching
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
-- Jump to start and end of line using the home row keys
vim.keymap.set("", "H", "^")
vim.keymap.set("", "L", "$")
-- Neat X clipboard integration
-- <leader>p will paste clipboard into buffer
-- <leader>c will copy entire buffer into clipboard
vim.keymap.set("n", "<leader>p", "<cmd>read !wl-paste<cr>")
vim.keymap.set("n", "<leader>c", "<cmd>w !wl-copy<cr><cr>")

-- <leader><leader> toggles between buffers
vim.keymap.set("n", "<leader><leader>", "<c-^>")
-- <leader>, shows/hides hidden characters
vim.keymap.set("n", "<leader>,", ":set invlist<cr>")
-- always center search results
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })
-- "very magic" (less escaping needed) regexes by default
vim.keymap.set("n", "?", "?\\v")
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("c", "%s/", "%sm/")
-- open new file adjacent to current file
vim.keymap.set("n", "<leader>o", ':e <C-R>=expand("%:p:h") . "/" <cr>')
-- no arrow keys --- force yourself to use the home row
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")
-- let the left and right arrows be useful: they can switch buffers
vim.keymap.set("n", "<left>", ":bp<cr>")
vim.keymap.set("n", "<right>", ":bn<cr>")
-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
-- handy keymap for replacing up to next _ (like in variable names)
vim.keymap.set("n", "<leader>m", "ct_")
-- F1 is pretty close to Esc, so you probably meant Esc
vim.keymap.set("", "<F1>", "<Esc>")
vim.keymap.set("i", "<F1>", "<Esc>")

-------------------------------------------------------------------------------
--
-- autocommands
--
-------------------------------------------------------------------------------
-- highlight yanked text
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   pattern = "*",
--   command = "silent! lua vim.highlight.on_yank({ timeout = 100 })",
-- })

-- jump to last edit position on opening file
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
            -- except for in git commit messages
            -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
            if not vim.fn.expand("%:p"):find(".git", 1, true) then
                vim.cmd 'exe "normal! g\'\\""'
            end
        end
    end,
})
-- prevent accidental writes to buffers that shouldn't be edited
vim.api.nvim_create_autocmd("BufRead", { pattern = "*.orig", command = "set readonly" })
vim.api.nvim_create_autocmd("BufRead", { pattern = "*.pacnew", command = "set readonly" })
-- leave paste mode when leaving insert mode (if it was on)
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "set nopaste" })
-- help filetype detection (add as needed)
--vim.api.nvim_create_autocmd('BufRead', { pattern = '*.ext', command = 'set filetype=someft' })
-- correctly classify mutt buffers
local email = vim.api.nvim_create_augroup("email", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "/tmp/mutt*",
    group = email,
    command = "setfiletype mail",
})
-- also, produce "flowed text" wrapping
-- https://brianbuccola.com/line-breaks-in-mutt-and-vim/
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "mail",
    group = email,
    command = "setlocal formatoptions+=w",
})
-- shorter columns in text because it reads better that way
local text = vim.api.nvim_create_augroup("text", { clear = true })
for _, pat in ipairs { "text", "markdown", "mail", "gitcommit" } do
    vim.api.nvim_create_autocmd("Filetype", {
        pattern = pat,
        group = text,
        command = "setlocal spell tw=72 colorcolumn=73",
    })
end
--- tex has so much syntax that a little wider is ok
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "tex",
    group = text,
    command = "setlocal spell tw=80 colorcolumn=81",
})
vim.o.termguicolors = true
vim.o.background = "dark"

-------------------------------------------------------------------------------
--
-- plugin configuration
--
-------------------------------------------------------------------------------
-- first, grab the manager
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)
-- then, setup!
require("lazy").setup {
    {
        "AxelGard/oneokai.nvim",
        lazy = false,    -- load at start
        priority = 1000, -- load firstl
        dependencies = {
            'rktjmp/lush.nvim',
            'tjdevries/colorbuddy.nvim',
        },
        config = function()
            vim.o.termguicolors = true
            vim.o.background = "dark"
            -- vim.cmd([[colorscheme vitesse]])
            require('oneokai').setup {
                style = 'warmer'
            }
            require('oneokai').load()
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },
    {
        'akinsho/bufferline.nvim',
        version = "^4",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('bufferline').setup {
            }
        end
    },
    {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                fps = 30,
                stages = 'static',
            }
        end

    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
            -- walkaround issue https://github.com/folke/noice.nvim/issues/1097
            messages = {
                enabled = false
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
        }
    },
    {
        'nvim-neo-tree/neo-tree.nvim',
        version = '^3',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
            'saifulapm/neotree-file-nesting-config',
        },
        lazy = false,
        keys = {
            { '<C-\\>', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
        },
        opts = {
            hide_root_node = true,
            retain_hidden_root_indent = true,
            filesystem = {
                filtered_items = {
                    show_hidden_count = false,
                    never_show = {
                        '.DS_Store',
                    },
                },
                window = {
                    mappings = {
                        ['<C-\\>'] = 'close_window',
                        ['c'] = {
                            'copy', config = { show_path = 'relative' }
                        }
                    },
                },
            },
            default_component_configs = {
                indent = {
                    with_expanders = true,
                    expander_collapsed = '',
                    expander_expanded = '',
                },
            },
        },
        config = function(_, opts)
            opts.nesting_rules = require('neotree-file-nesting-config').nesting_rules
            require('neo-tree').setup(opts)
        end,
    },
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            {
                'nvim-tree/nvim-web-devicons',
                enabled = vim.g.have_nerd_font
            },
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
                defaults = {
                    file_ignore_patterns = {
                        "%.next",
                        "%.git/",
                        "%.gitlab/",
                        ".terra*",
                        ".terra*/",
                        "node_modules/",
                        ".cache/",
                        ".gsutil/",
                        ".npm",
                        "target/",
                    }
                }
            }

            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
            vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
            vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
            vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
            vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
            vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

            local find_files = function()
                builtin.find_files { hidden = true }
            end

            vim.keymap.set('n', '<leader>ff', find_files, { desc = '[Find] [F]iles', silent = true, noremap = true })
            vim.keymap.set('n', '<C-p>', find_files, { desc = '[Find] [F]iles', silent = true, noremap = true })

            vim.keymap.set('n', '<leader>/', function()
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[F]ind [/] in Open Files' })

            vim.keymap.set('n', '<leader>fn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[F]ind [N]eovim files' })
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'auto',
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,
                            path = 1,
                        }
                    },
                },
            })
        end },
    {
        "j-hui/fidget.nvim",
        opts = {},
    },
    -- LSP
    {
        "williamboman/mason.nvim",
        config = function()
            require "mason".setup {}
        end

    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "lua_ls", "rust_analyzer" },
            }
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Setup language servers.

            -- Go
            vim.lsp.config['gopls'] = {}

            -- Bash LSP
            local configs = require "lspconfig.configs"
            if not configs.bash_lsp and vim.fn.executable "bash-language-server" == 1 then
                configs.bash_lsp = {
                    default_config = {
                        cmd = { "bash-language-server", "start" },
                        filetypes = { "sh" },
                        root_dir = require("lspconfig").util.find_git_ancestor,
                        init_options = {
                            settings = {
                                args = {},
                            },
                        },
                    },
                }
            end

            if configs.bash_lsp then
                vim.lsp.config['bash_lsp'] = {}
            end

            -- Ruff for Python
            local configs = require "lspconfig.configs"
            if not configs.ruff_lsp and vim.fn.executable "ruff-lsp" == 1 then
                configs.ruff_lsp = {
                    default_config = {
                        cmd = { "ruff-lsp" },
                        filetypes = { "python" },
                        root_dir = require("lspconfig").util.find_git_ancestor,
                        init_options = {
                            settings = {
                                args = {},
                            },
                        },
                    },
                }
            end
            if configs.ruff_lsp then
                vim.lsp.config['ruff_lsp'] = {}
            end

            vim.lsp.config['lua_ls'] = {
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                            path = vim.split(package.path, ";"),
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim" },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files and plugins
                            library = { vim.env.VIMRUNTIME },
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', function()
                vim.diagnostic.jump({ count = -1, float = true })
            end)
            vim.keymap.set('n', ']d', function()
                vim.diagnostic.jump({ count = 1, float = true })
            end)
            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

            vim.diagnostic.config({ virtual_text = true })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = ev.buf,
                        callback = function()
                            vim.lsp.buf.format { async = false, id = ev.data.client_id }
                        end,
                    })

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    -- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
                    -- *and* there's some way to make it only apply to the current line.
                    -- if client.server_capabilities.inlayHintProvider then
                    --     vim.lsp.inlay_hint(ev.buf, true)
                    -- end

                    -- None of this semantics tokens business.
                    -- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
                    if client ~= nil then
                        client.server_capabilities.semanticTokensProvider = nil
                    end
                end,
            })
        end,
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^6',
        lazy = false,
        config = function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.keymap.set("n", "<leader>a", function()
                vim.cmd.RustLsp('codeAction')
            end, { silent = true, buffer = bufnr })

            vim.keymap.set("n", "K", function()
                vim.cmd.RustLsp({ 'hover', 'action' })
            end, { silent = true, buffer = bufnr })


            vim.g.rustaceanvim = {
                server = {
                    on_attach = function()
                        vim.cmd.RustAnalyzer { 'config', '{ checkOnSave = false }' }
                    end,
                },
            }
        end

    },
    -- LSP-based code-completion
    {
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/vim-vsnip",
        },
        config = function()
            local cmp = require "cmp"
            cmp.setup {
                snippet = {
                    -- REQUIRED by nvim-cmp. get rid of it once we can
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    -- Accept currently selected item.
                    -- Set `select` to `false` to only confirm explicitly selected items.
                    --
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    })
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                }, {
                    { name = "path" },
                }, {
                    { name = 'vsnip' },
                }),
                experimental = {
                    ghost_text = true,
                },
            }

            -- Enable completing paths in :
            cmp.setup.cmdline(":", {
                sources = cmp.config.sources {
                    { name = "path" },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "python", "bash" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    -- language support
    -- terraform
    {
        "hashivim/vim-terraform",
        ft = { "terraform" },
    },
    -- svelte
    {
        "evanleck/vim-svelte",
        ft = { "svelte" },
    },
    -- toml
    "cespare/vim-toml",
    -- yaml
    {
        "cuducos/yaml.nvim",
        ft = { "yaml" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    -- rust
    {
        "rust-lang/rust.vim",
        ft = { "rust" },
        config = function()
            vim.g.rustfmt_autosave = 1
            vim.g.rustfmt_emit_files = 1
            vim.g.rustfmt_fail_silently = 0
            vim.g.rust_clip_command = "wl-copy"
        end,
    },
    -- fish
    "khaveesh/vim-fish-syntax",
    -- markdown
    {
        "plasticboy/vim-markdown",
        ft = { "markdown" },
        dependencies = {
            "godlygeek/tabular",
        },
        config = function()
            -- never ever fold!
            vim.g.vim_markdown_folding_disabled = 1
            -- support front-matter in .md files
            vim.g.vim_markdown_frontmatter = 1
            -- 'o' on a list item should insert at same level
            vim.g.vim_markdown_new_list_item_indent = 0
            -- don't add bullets when wrapping:
            -- https://github.com/preservim/vim-markdown/issues/232
            vim.g.vim_markdown_auto_insert_bullets = 0
        end,
    },
}
