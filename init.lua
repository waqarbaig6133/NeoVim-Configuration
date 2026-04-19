-- ============================================================
--  WaqarVim - Simple & Clean Neovim Config
-- ============================================================

-- Leader key
vim.g.mapleader = " "

-- ── Basic Options ───────────────────────────────────────────
vim.opt.number         = true
vim.opt.relativenumber = false
vim.opt.termguicolors  = true
vim.opt.expandtab      = true
vim.opt.shiftwidth     = 2
vim.opt.tabstop        = 2
vim.opt.swapfile       = false
vim.opt.wrap           = false
vim.opt.clipboard      = "unnamedplus"
vim.opt.mouse          = "a"
vim.opt.showmode       = false
vim.opt.cursorline     = true
vim.opt.scrolloff      = 8

-- ── Bootstrap lazy.nvim ─────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ── Plugins ─────────────────────────────────────────────────
require("lazy").setup({

  -- Colorscheme (navy blue base)
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false,
        theme   = "wave",
      })
      vim.cmd.colorscheme("kanagawa-wave")
      -- Pastel navy background
      vim.api.nvim_set_hl(0, "Normal",     { bg = "#1e2127" })
      vim.api.nvim_set_hl(0, "NormalNC",   { bg = "#1e2127" })
      vim.api.nvim_set_hl(0, "EndOfBuffer",{ bg = "#1e2127", fg = "#1e2127" })
    end,
  },

  -- Minimal statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme                = "auto",
          section_separators   = "",
          component_separators = "│",
          globalstatus         = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "filename" },
          lualine_c = {},
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Telescope (fuzzy finder + recent files popup)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix   = "  ",
          selection_caret = " ❯ ",
          layout_config   = { width = 0.6, height = 0.5 },
          borderchars     = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
      })
    end,
  },

  -- Autopairs
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },


  -- Tabs (bufferline)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode              = "buffers",
          separator_style   = "slant",
          show_buffer_close_icons = true,
          show_close_icon   = false,
          color_icons       = true,
          always_show_bufferline = false,
        },
        highlights = {
          fill                  = { bg = "#1e2127" },
          background            = { bg = "#1e2127", fg = "#555b6e" },
          buffer_selected       = { bg = "#2e4f8a", fg = "#ffffff", bold = true },
          buffer_visible        = { bg = "#1e2127", fg = "#7a8099" },
          separator             = { bg = "#1e2127", fg = "#1e2127" },
          separator_selected    = { bg = "#2e4f8a", fg = "#1e2127" },
          close_button          = { bg = "#1e2127", fg = "#555b6e" },
          close_button_selected = { bg = "#2e4f8a", fg = "#ffffff" },
          modified              = { bg = "#1e2127", fg = "#FF4444" },
          modified_selected     = { bg = "#2e4f8a", fg = "#FF4444" },
        },
      })
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },

}, { ui = { border = "rounded" } })

-- ╔══════════════════════════════════════════════════════════╗
-- ║              WAQARVIM DASHBOARD                         ║
-- ╚══════════════════════════════════════════════════════════╝

local function draw_dashboard()
  if vim.fn.argc() > 0 then return end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)
  vim.bo[buf].buftype    = "nofile"
  vim.bo[buf].bufhidden  = "wipe"
  vim.bo[buf].modifiable = true
  vim.bo[buf].swapfile   = false

  local width  = vim.o.columns
  local height = vim.o.lines

  -- Big block-letter title (Claude CLI aesthetic)
  local title = {
    "",
    "██╗    ██╗ █████╗  ██████╗  █████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
    "██║    ██║██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██║   ██║██║████╗ ████║",
    "██║ █╗ ██║███████║██║   ██║███████║██████╔╝██║   ██║██║██╔████╔██║",
    "██║███╗██║██╔══██║██║▄▄ ██║██╔══██║██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║",
    "╚███╔███╔╝██║  ██║╚██████╔╝██║  ██║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║",
    " ╚══╝╚══╝ ╚═╝  ╚═╝ ╚══▀▀═╝ ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
    "",
    "",
    "",
  }

  -- Find widest line to anchor centering
  local max_w = 0
  for _, l in ipairs(title) do
    local w = vim.fn.strwidth(l)
    if w > max_w then max_w = w end
  end

  -- Center: offset the whole block to mid-screen, then center each line within block
  local function center(str)
    local block_offset = math.max(0, math.floor((width - max_w) / 2))
    local inner_offset = math.max(0, math.floor((max_w - vim.fn.strwidth(str)) / 2))
    return string.rep(" ", block_offset + inner_offset) .. str
  end
  local menu = {
    { icon = "  ", label = "Open File",     key = "o",
      action = function() require("telescope.builtin").find_files() end },
    { icon = "  ", label = "Recent Files",  key = "r",
      action = function() require("telescope.builtin").oldfiles()   end },
    { icon = "  ", label = "New File",      key = "n",
      action = function()
        vim.ui.input({ prompt = "  Filename: " }, function(name)
          if name and name ~= "" then
            vim.cmd("edit " .. vim.fn.fnameescape(name))
          end
        end)
      end },
    { icon = "  ", label = "Find in Files", key = "f",
      action = function() require("telescope.builtin").live_grep()  end },
    { icon = "  ", label = "Settings",      key = "s",
      action = function() vim.cmd("edit $MYVIMRC") end },
    { icon = "  ", label = "Quit",          key = "q",
      action = function() vim.cmd("qa") end },
  }

  -- Build content lines
  local content = {}
  for _, l in ipairs(title) do
    table.insert(content, center(l))
  end

  local menu_line_start = #content  -- 0-indexed line where first menu item goes
  for _, item in ipairs(menu) do
    table.insert(content, center(item.icon .. item.label .. "   [" .. item.key .. "]"))
    table.insert(content, "")
  end

  table.insert(content, "")
  table.insert(content, center("↑ / ↓  navigate    Enter  select"))
  table.insert(content, "")

  -- Vertical padding
  local top_pad = math.max(0, math.floor((height - #content) / 2))
  local all_lines = {}
  for _ = 1, top_pad do table.insert(all_lines, "") end
  for _, l in ipairs(content) do table.insert(all_lines, l) end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, all_lines)
  vim.bo[buf].modifiable = false

  -- ── Highlight groups ──────────────────────────────────────
  vim.api.nvim_set_hl(0, "WaqarTitle",    { fg = "#FF4444", bold = true })
  vim.api.nvim_set_hl(0, "WaqarSubtitle", { fg = "#7aa0c9", italic = true })
  vim.api.nvim_set_hl(0, "WaqarSelected", { fg = "#FFFFFF", bg = "#2e4f8a", bold = true })
  vim.api.nvim_set_hl(0, "WaqarItem",     { fg = "#8ab4e0" })
  vim.api.nvim_set_hl(0, "WaqarHint",     { fg = "#4a6a9a", italic = true })

  local ns = vim.api.nvim_create_namespace("waqarvim")
  local selected = 1

  local function refresh_highlights()
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    -- Title lines (lines 1..#title in content, offset by top_pad)
    for i = 1, #title do
      local row = top_pad + i - 1
      if i == #title - 2 then  -- subtitle "your editor, your rules."
        vim.api.nvim_buf_add_highlight(buf, ns, "WaqarSubtitle", row, 0, -1)
      else
        vim.api.nvim_buf_add_highlight(buf, ns, "WaqarTitle", row, 0, -1)
      end
    end
    -- Menu items (every other line after title block)
    for i, _ in ipairs(menu) do
      local row = top_pad + menu_line_start + (i - 1) * 2
      vim.api.nvim_buf_add_highlight(
        buf, ns,
        i == selected and "WaqarSelected" or "WaqarItem",
        row, 0, -1
      )
    end
    -- Hint line
    local hint_row = top_pad + menu_line_start + #menu * 2 + 1
    vim.api.nvim_buf_add_highlight(buf, ns, "WaqarHint", hint_row, 0, -1)
  end

  refresh_highlights()

  -- ── Navigation ────────────────────────────────────────────
  local opts = { buffer = buf, nowait = true, silent = true }

  vim.keymap.set("n", "<Down>", function()
    selected = (selected % #menu) + 1
    refresh_highlights()
  end, opts)

  vim.keymap.set("n", "<Up>", function()
    selected = ((selected - 2) % #menu) + 1
    refresh_highlights()
  end, opts)

  vim.keymap.set("n", "j", function()
    selected = (selected % #menu) + 1
    refresh_highlights()
  end, opts)

  vim.keymap.set("n", "k", function()
    selected = ((selected - 2) % #menu) + 1
    refresh_highlights()
  end, opts)

  vim.keymap.set("n", "<CR>", function()
    menu[selected].action()
  end, opts)

  -- Shortcut keys
  for _, item in ipairs(menu) do
    vim.keymap.set("n", item.key, item.action, opts)
  end

  -- Block accidental edits
  for _, k in ipairs({ "i", "a", "o", "O", "x", "d", "c", "p" }) do
    vim.keymap.set("n", k, "<Nop>", opts)
  end
end

-- Launch on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(draw_dashboard, 15)
  end,
})

-- Return to dashboard
vim.keymap.set("n", "<leader>m", function()
  vim.cmd("silent! wa")       -- save all modified buffers first
  vim.cmd("silent! %bdelete!")
  draw_dashboard()
end, { desc = "Menu / Dashboard" })

-- ── Keymaps for normal editing ──────────────────────────────
vim.keymap.set("n", "<leader>o", function() require("telescope.builtin").find_files() end, { desc = "Open File"    })
vim.keymap.set("n", "<leader>r", function() require("telescope.builtin").oldfiles()   end, { desc = "Recent Files" })
vim.keymap.set("n", "<leader>f", function() require("telescope.builtin").live_grep()  end, { desc = "Find in Files"})
vim.keymap.set("n", "<leader>n", function()
  vim.ui.input({ prompt = "  New file name: " }, function(name)
    if name and name ~= "" then
      vim.cmd("edit " .. vim.fn.fnameescape(name))
    end
  end)
end, { desc = "New File" })
vim.keymap.set("n", "<Esc>",     "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-h>",     "<C-w>h")
vim.keymap.set("n", "<C-l>",     "<C-w>l")
vim.keymap.set("n", "<C-j>",     "<C-w>j")
vim.keymap.set("n", "<C-k>",     "<C-w>k")

-- ── Help popup (Space h) ────────────────────────────────────
local function show_help()
  local lines = {
    "",
    "  ╭─────────────────────────────────────────────────╮",
    "  │              WAQARVIM  KEYBINDS                 │",
    "  ├─────────────────────────────────────────────────┤",
    "  │                                                 │",
    "  │  DASHBOARD                                      │",
    "  │  Space m       Return to menu                   │",
    "  │  Space h       Show this help                   │",
    "  │                                                 │",
    "  │  FILES                                          │",
    "  │  Space o       Open file picker                 │",
    "  │  Space r       Recent files                     │",
    "  │  Space n       New file                         │",
    "  │  Space f       Search text in project           │",
    "  │                                                 │",
    "  │  EDITOR                                         │",
    "  │  i             Enter insert mode (type)         │",
    "  │  Esc           Back to normal mode              │",
    "  │  :w            Save file                        │",
    "  │  :q            Quit                             │",
    "  │  :wq           Save and quit                    │",
    "  │  u             Undo                             │",
    "  │  Ctrl+r        Redo                             │",
    "  │  dd            Delete line                      │",
    "  │  yy            Copy line                        │",
    "  │  p             Paste                            │",
    "  │  gg / G        Top / Bottom of file             │",
    "  │  w / b         Next / Prev word                 │",
    "  │                                                 │",
    "  │  SPLITS                                         │",
    "  │  Space sv      Split vertical (side by side)    │",
    "  │  Space sh      Split horizontal (top/bottom)    │",
    "  │  Space sq      Close split                      │",
    "  │  Space se      Make splits equal size           │",
    "  │  Ctrl h/j/k/l  Move between splits              │",
    "  │                                                 │",
    "  │  WINDOWS                                        │",
    "  │  Ctrl h/j/k/l  Move between splits              │",
    "  │                                                 │",
    "  │  Press Esc to close this panel                  │",
    "  ╰─────────────────────────────────────────────────╯",
    "",
  }

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype   = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  -- Calculate centered float position
  local w = 53
  local h = #lines
  local row = math.floor((vim.o.lines - h) / 2)
  local col = math.floor((vim.o.columns - w) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width    = w,
    height   = h,
    row      = row,
    col      = col,
    style    = "minimal",
    border   = "none",
  })

  -- Highlights
  vim.api.nvim_set_hl(0, "HelpBorder",  { fg = "#4a7abf" })
  vim.api.nvim_set_hl(0, "HelpHeader",  { fg = "#FF4444", bold = true })
  vim.api.nvim_set_hl(0, "HelpSection", { fg = "#7aa0c9", bold = true })
  vim.api.nvim_set_hl(0, "HelpKey",     { fg = "#FFFFFF" })
  vim.api.nvim_set_hl(0, "HelpDesc",    { fg = "#8ab4e0" })

  local ns = vim.api.nvim_create_namespace("waqarvim_help")
  -- Header
  vim.api.nvim_buf_add_highlight(buf, ns, "HelpBorder", 1, 0, -1)
  vim.api.nvim_buf_add_highlight(buf, ns, "HelpHeader", 2, 0, -1)
  vim.api.nvim_buf_add_highlight(buf, ns, "HelpBorder", 3, 0, -1)
  -- Section labels + border lines
  local section_rows = { 5, 10, 16, 27, 31, 33 }
  for _, r in ipairs(section_rows) do
    vim.api.nvim_buf_add_highlight(buf, ns, "HelpSection", r, 0, -1)
  end
  -- All other content lines
  for i = 0, h - 1 do
    vim.api.nvim_buf_add_highlight(buf, ns, "HelpBorder", i, 2, 4)      -- left border │
    vim.api.nvim_buf_add_highlight(buf, ns, "HelpBorder", i, w - 2, -1) -- right border │
  end
  vim.api.nvim_buf_add_highlight(buf, ns, "HelpBorder", h - 2, 0, -1)
  vim.api.nvim_buf_add_highlight(buf, ns, "HelpDesc",   h - 3, 0, -1)

  -- Close on Esc
  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, nowait = true, silent = true })
end

vim.keymap.set("n", "<leader>h", show_help, { desc = "Help / Keybinds" })

-- ── Split windows ──────────────────────────────────────────
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>",  { silent = true, desc = "Split Vertical"   })
vim.keymap.set("n", "<leader>sh", ":split<CR>",   { silent = true, desc = "Split Horizontal" })
vim.keymap.set("n", "<leader>sq", ":close<CR>",   { silent = true, desc = "Close Split"      })
vim.keymap.set("n", "<leader>se", "<C-w>=",       { silent = true, desc = "Equal Splits"     })

-- ── Tab / Buffer navigation ─────────────────────────────────
vim.keymap.set("n", "<S-l>",      ":BufferLineCycleNext<CR>",  { silent = true, desc = "Next Tab"     })
vim.keymap.set("n", "<S-h>",      ":BufferLineCyclePrev<CR>",  { silent = true, desc = "Prev Tab"     })
vim.keymap.set("n", "<leader>x",  ":bdelete<CR>",              { silent = true, desc = "Close Tab"    })
vim.keymap.set("n", "<leader>1",  ":BufferLineGoToBuffer 1<CR>", { silent = true, desc = "Go to Tab 1" })
vim.keymap.set("n", "<leader>2",  ":BufferLineGoToBuffer 2<CR>", { silent = true, desc = "Go to Tab 2" })
vim.keymap.set("n", "<leader>3",  ":BufferLineGoToBuffer 3<CR>", { silent = true, desc = "Go to Tab 3" })
vim.keymap.set("n", "<leader>4",  ":BufferLineGoToBuffer 4<CR>", { silent = true, desc = "Go to Tab 4" })
vim.keymap.set("n", "<leader>5",  ":BufferLineGoToBuffer 5<CR>", { silent = true, desc = "Go to Tab 5" })
