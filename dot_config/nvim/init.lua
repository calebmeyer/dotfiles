vim.g.mapleader = " "

-- Options -------------------------------------------------------------

local opt = vim.opt

opt.number = true
opt.termguicolors = true
opt.background = "dark"

opt.colorcolumn = "80,120"
opt.cursorline = true
opt.guicursor:append("a:blinkon0") -- turn off cursor blinking

opt.scrolloff = 8
opt.sidescrolloff = 15
opt.sidescroll = 1

opt.list = true
opt.listchars = { tab = "  ", trail = "·" }

opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.shiftwidth = 2
opt.softtabstop = 2
opt.shiftround = true
opt.expandtab = true

opt.incsearch = true
opt.autowrite = true
opt.backspace = { "indent", "eol", "start" }

opt.foldenable = false -- turn folds back on with zi
opt.foldmethod = "indent"

if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Restore cursor to last known position, except for commit messages.
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local ft = vim.bo.filetype
    local mark = vim.fn.line("'\"")
    if ft ~= "gitcommit" and mark > 0 and mark <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})

-- Plugins (lazy.nvim) ---------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Git
  { "tpope/vim-fugitive" },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- Rails dev
  { "tpope/vim-haml", ft = { "haml" } },
  { "groenewege/vim-less", ft = { "less" } },
  { "tpope/vim-rails", ft = { "ruby", "eruby" } },
  { "plasticboy/vim-markdown", ft = { "markdown" } },
  { "bruno-/vim-ruby-fold", ft = { "ruby" } },
  { "thoughtbot/vim-rspec" },

  -- File browser sidebar (replaces NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },

  -- Fuzzy finder (replaces ctrlp)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files)
      vim.keymap.set("n", "<leader>ff", builtin.find_files)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep)
      vim.keymap.set("n", "<leader>fb", builtin.buffers)
      vim.keymap.set("n", "<leader>fh", builtin.help_tags)
    end,
  },

  -- Statusline + tabline (replaces airline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { options = { theme = "catppuccin", globalstatus = true } },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        offsets = {
          { filetype = "NvimTree", text = "File Explorer", highlight = "Directory", text_align = "left" },
        },
      },
    },
  },

  -- :Tab /<character to align>
  { "godlygeek/tabular" },

  -- cs"' to change surrounding quotes/brackets/tags (replaces vim-surround)
  { "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = true },

  -- golang development
  { "fatih/vim-go", ft = { "go" } },

  -- highlights + trims trailing whitespace (replaces vim-better-whitespace)
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.trailspace").setup()
    end,
  },

  -- Session management (replaces vim-obsession/vim-prosession)
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        auto_session_root_dir = vim.fn.expand("~/.vim_sessions/"),
      })
    end,
  },

  -- gc/gcc to comment or uncomment (replaces nerdcommenter)
  { "numToStr/Comment.nvim", config = true },

  -- Rainbow parentheses
  {
    "luochen1990/rainbow",
    lazy = false,
    init = function()
      vim.g.rainbow_active = 1
    end,
  },

  -- Fish support
  { "dag/vim-fish", ft = { "fish" } },

  -- Tom's Obvious Minimal Language support
  { "cespare/vim-toml", ft = { "toml" } },
})

-- Keymaps ---------------------------------------------------------------

vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>nt", ":NvimTreeFindFile<cr>")

vim.keymap.set("n", "<Tab>", ":bnext<cr>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<cr>")

vim.keymap.set("n", "F", "@=(foldlevel('.')?'za':\"\\<Space>\")<cr>", { silent = true })
vim.keymap.set("v", "F", "zf")

vim.keymap.set("n", ";", ":")

-- fugitive shortcuts
vim.keymap.set("n", "<leader>gs", ":Git<cr>")
vim.keymap.set("n", "<leader>gc", ":Git commit<cr>")
vim.keymap.set("n", "<leader>ga", ":Git add -A<cr>")
vim.keymap.set("n", "<leader>gl", ":Git log<cr>")
vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<cr>")
vim.keymap.set("n", "<leader>gb", ":Git blame<cr>")
vim.keymap.set("n", "<leader>gp", ":Git push<cr>")

-- more shortcuts
vim.keymap.set("n", "<leader>fs", ":w<cr>")
vim.keymap.set("n", "<leader>qq", ":q!<cr>")

-- rspec
vim.g.rspec_runner = "os_x_iterm"
vim.keymap.set("n", "<leader>rf", ":call RunCurrentSpecFile()<cr>")
vim.keymap.set("n", "<leader>rc", ":call RunNearestSpec()<cr>")
vim.keymap.set("n", "<leader>rl", ":call RunLastSpec()<cr>")
vim.keymap.set("n", "<leader>rr", ":call RunAllSpecs()<cr>")
vim.keymap.set("n", "<leader>rit", ":! bundle exec ruby spec/integration/integration.rb<cr>")

-- quickly edit/reload this config
vim.keymap.set("n", "<leader>ev", ":edit $MYVIMRC<cr>", { silent = true })
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<cr>", { silent = true })
