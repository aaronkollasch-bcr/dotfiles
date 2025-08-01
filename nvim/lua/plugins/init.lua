return {
    -- icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        cond = require("ak.opts").icons_enabled,
    },

    -- cloak
    {
        "laytan/cloak.nvim",
        opts = {},
    },

    -- extra language support
    {
        "NoahTheDuke/vim-just",
        ft = "just",
        config = function()
            vim.cmd([[ syntax enable ]])
        end,
    },
    { "ckipp01/stylua-nvim", lazy = true },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },
    {
        "aaronkollasch/vim-known_hosts",
        dev = false,
        ft = "known_hosts",
        config = function()
            vim.cmd([[ syntax enable ]])
        end,
    },
    {
        "hat0uma/csvview.nvim",
        ft = {
            "csv",
            "tsv",
        },
        -- stylua: ignore
        keys = {
            { '[c', ":lua require('csvview.jump').prev_field_start()<cr>", mode = 'n', silent = true, desc = "Previous CSV column" },
            { ']c', ":lua require('csvview.jump').next_field_start()<cr>", mode = 'n', silent = true, desc = "Next CSV column" },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
        opts = {
            parser = { comments = { "#", "//" } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
            view = {
                header_lnum = 1,
                sticky_header = {
                    separator = false,
                },
            },
        },
    },

    -- additional info sources
    {
        "rizzatti/dash.vim",
        cmd = {
            "Dash",
            "DashKeywords",
        },
        -- stylua: ignore
        keys = {
            { "<leader>K",  "<Plug>DashSearch", silent = true, desc = "Dash Search" },
            { "<S-Space>K", "<Plug>DashSearch", silent = true, desc = "Dash Search" },
        },
        cond = function()
            return vim.uv.os_uname().sysname == "Darwin"
        end,
    },
    {
        "KabbAmine/zeavim.vim",
        cmd = {
            "Zeavim",
            "Docset",
            "ZeavimV",
        },
        -- stylua: ignore
        keys = {
            { "<leader>K",  "<Plug>Zeavim", silent = true, desc = "Zeal Search" },
            { "<S-Space>K", "<Plug>Zeavim", silent = true, desc = "Zeal Search" },
            { "<leader>K",  "<Plug>ZVVisSelection", mode = "x", silent = true, desc = "Zeal Search" },
            { "<S-Space>K", "<Plug>ZVVisSelection", mode = "x", silent = true, desc = "Zeal Search" },
        },
        init = function()
            vim.g.zv_disable_mapping = 1
            if vim.fn.has("unix") then
                vim.g.zv_zeal_args = "--style=gtk+"
            end
        end,
        cond = function()
            return vim.uv.os_uname().sysname ~= "Darwin"
        end,
    },

    -- popups
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "[U]ndotree Toggle" },
        },
        config = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        -- stylua: ignore
        keys = {
            { "<leader>wt", "<cmd>Trouble diagnostics toggle<cr>",               desc = "[W]orkspace [T]rouble" },
            { "<leader>bt", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",  desc = "[B]uffer [T]rouble" },
        },
        opts = {},
    },
    {
        "BooleanCube/keylab.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        lazy = true,
        keys = {
            { "<leader>kl", "<cmd>lua require('keylab').start()<cr>", desc = "[K]ey[L]ab" },
        },
        opts = {},
    },
    {
        "ecthelionvi/NeoComposer.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        event = "VeryLazy",
        config = function()
            local opts = {
                keymaps = {
                    play_macro = "Q",
                    yank_macro = "yq",
                    stop_macro = "cq",
                    toggle_record = "q",
                    cycle_next = "<c-m>",
                    cycle_prev = "<c-s-m>",
                    toggle_macro_menu = "<c-q>",
                },
            }
            require("NeoComposer").setup(opts)
            require("NeoComposer.store").load_macros_from_database()
            require("NeoComposer.state").set_queued_macro_on_startup()
            vim.cmd([[ hi! link ComposerNormal Normal ]])
        end,
    },
    {
        "NStefan002/screenkey.nvim",
        version = "*",
        cmd = "Screenkey",
        keys = {
            { "<leader>ks", "<cmd>Screenkey toggle<cr>", desc = "[K]ey[S]creen" },
        },
        opts = {
            group_mappings = true,
            keys = {
                ["<SPACE>"] = "<Spc>",
            },
        },
    },

    -- buffer highlighting
    {
        "itchyny/vim-cursorword",
        event = "VeryLazy",
        init = function()
            vim.g.cursorword_delay = 300
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = "VeryLazy",
        cmd = "TodoTelescope",
        keys = { { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "[F]ind [T]odos" } },
        opts = {
            keywords = {
                TODO = { alt = { "todo", "unimplemented" } },
            },
            highlight = {
                pattern = {
                    [[.*<(KEYWORDS)\s*:]],
                    [[.*<(KEYWORDS)\s*!\(]],
                },
                comments_only = false,
            },
            search = {
                pattern = [[\b(KEYWORDS)(:|!\()]],
            },
        },
    },
    {
        "brenoprata10/nvim-highlight-colors",
        ft = {
            "css",
            "javascript",
            "html",
        },
        cmd = "HighlightColors",
        keys = { { "<leader>ih", "<cmd>HighlightColors Toggle<CR>", desc = "[I]nspect [H]excodes" } },
        config = function()
            require("nvim-highlight-colors").setup({
                render = "virtual",
                virtual_symbol = "██",
            })
            if
                not vim.tbl_contains(
                    { "css", "html", "javascript" },
                    vim.filetype.match({ buf = vim.api.nvim_get_current_buf() })
                )
            then
                require("nvim-highlight-colors").turnOff()
            end
        end,
    },
    {
        "tzachar/highlight-undo.nvim",
        event = "VeryLazy",
        opts = {
            duration = 200,
            keymaps = {
                undo = {
                    hlgroup = "IncSearch",
                    opts = {
                        desc = "Undo",
                    },
                },
                redo = {
                    hlgroup = "IncSearch",
                    opts = {
                        desc = "Redo",
                    },
                },
            },
        },
    },

    -- tpope
    { "tpope/vim-sleuth", event = { "BufReadPre", "BufNewFile" } },
    { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} }, -- replaces tpope/vim-commentary
    {
        "tpope/vim-fugitive",
        cmd = {
            "G",
            "Git",
            "Gdiff",
            "Gdiffsplit",
        },
        -- stylua: ignore
        keys = {
            { "<leader>gs", vim.cmd.Git, desc = "[G]it [S]tart" },
            { "<leader>gc", function() vim.cmd.Git("commit -v") end, desc = "[G]it [C]ommit" },
            { "<leader>ge", function() vim.cmd.Git("commit -v --amend --no-edit") end, desc = "[G]it [E]dit commit" },
            { "<leader>gb", function() vim.cmd.Git("blame -w -C -C -C") end, desc = "[G]it [B]lame" },
        },
    },
    { "kylechui/nvim-surround", event = "VeryLazy", opts = {} }, -- replaces tpope/vim-surround
    { "tpope/vim-repeat", event = "VeryLazy" },
    { "tpope/vim-characterize", keys = { { "<leader>ic", "<Plug>(characterize)", desc = "[I]nspect [C]haracter" } } },

    -- text actions
    {
        "junegunn/vim-easy-align",
        cmd = "EasyAlign",
        keys = {
            -- n: Start interactive EasyAlign for a motion/text object (e.g. gaip)
            -- x: Start interactive EasyAlign in visual mode (e.g. vipga)
            { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "EasyAlign" },
        },
    },
    {
        "aaronkollasch/treesj",
        -- stylua: ignore
        keys = {
            { "gS", function() require('treesj').toggle() end, mode = { "n", "x" }, desc = "Toggle arguments" },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            use_default_keymaps = false,
        },
    },
    { "mrjones2014/lua-gf.nvim", ft = "lua" },
    {
        "chrishrb/gx.nvim",
        keys = {
            { "gx", "<cmd>Browse<cr>", mode = { "n", "x" }, desc = "Open URL under cursor" },
        },
        -- event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    -- {
    --     "smjonas/inc-rename.nvim",
    --     keys = {
    --         { "<leader>rn",function()
    --             return ":IncRename " .. vim.fn.expand("<cword>")
    --         end, expr = true, desc = "[R]e[N]ame" },
    --     },
    --     opts = {},
    -- },
    -- {
    --     "smjonas/live-command.nvim",
    --     cmd = { "Norm", "Reg" },
    --     config = function()
    --         require("live-command").setup {
    --             commands = {
    --                 Norm = { cmd = "norm" },
    --                 Reg = {
    --                     cmd = "norm",
    --                     -- This will transform ":5Reg a" into ":norm 5@a"
    --                     args = function(opts)
    --                         return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
    --                     end,
    --                     range = "",
    --                 },
    --             },
    --         }
    --     end,
    -- },

    -- get github permalink
    {
        "knsh14/vim-github-link",
        cmd = {
            "GetCommitLink",
            "GetCurrentBranchLink",
            "GetCurrentCommitLink",
        },
        -- stylua: ignore
        keys = {
            { "<leader>gp", ":GetCurrentCommitLink<CR>", mode = { "n", "x" }, silent = true, desc = "[G]it [P]ermalink" },
        },
    },

    -- better <leader>p
    { "inkarkat/vim-ReplaceWithRegister", event = "VeryLazy" },

    -- colorscheme
    {
        "aaronkollasch/edge",
        dev = false,
        priority = 1000,
        config = function()
            require("ak.colors")
        end,
    },
    { "aaronkollasch/darcula", dev = false, ft = "python" }, -- fork of doums/darcula
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {
            day_brightness = 0.25,
            lualine_bold = true,
        },
    },

    -- <leader>fml
    {
        "Eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
        keys = {
            { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "FML" },
        },
    },
}
