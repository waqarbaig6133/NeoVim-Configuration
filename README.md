# WaqarVim

> A clean, minimal Neovim config with a custom TUI dashboard — for people like me who want it easy

```
██╗    ██╗ █████╗  ██████╗  █████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
██║    ██║██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██║   ██║██║████╗ ████║
██║ █╗ ██║███████║██║   ██║███████║██████╔╝██║   ██║██║██╔████╔██║
██║███╗██║██╔══██║██║▄▄ ██║██╔══██║██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║
╚███╔███╔╝██║  ██║╚██████╔╝██║  ██║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚══╝╚══╝ ╚═╝  ╚═╝ ╚══▀▀═╝ ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
```

---

## Requirements

- [Neovim](https://neovim.io/) >= 0.10
- [Git](https://git-scm.com/)
- A [Nerd Font](https://www.nerdfonts.com/) set in your terminal (for icons)
- `ripgrep` (`rg`) — for text search across files

---

## Installation

```bash
# Backup your existing config if you have one
mv ~/.config/nvim ~/.config/nvim.bak

# Create the config directory
mkdir -p ~/.config/nvim

# Copy init.lua into it
cp init.lua ~/.config/nvim/init.lua

# Open Neovim — plugins will auto-install on first launch
nvim
```

Wait for lazy.nvim to finish installing all plugins, then restart nvim.

---

## Features

### Custom TUI Dashboard
I have my name + Vim, just cause it's my workspace, it would be weird if you kept it after cloning my config.

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0c05c9bc-7dd7-432f-8ccb-300297b719b2" />

- Arrow keys or `j`/`k` to navigate
- `Enter` to select, or tap the shortcut key directly
- Automatically shows on startup, return to it anytime with `Space m`

### File Finder
Powered by [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) — instantly search files, recent files, and text across your whole project with live preview.
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5018765c-7689-4067-b4db-6580a314d5fa" />


### Buffer Tabs
A tab bar at the top powered by [bufferline.nvim](https://github.com/akinsho/bufferline.nvim). Tabs appear when you have more than one file open.
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/dc5b72ad-57ea-4312-a3c1-e292de1628d2" />


### Split Windows
Split your editor into multiple panes side by side or top/bottom — just like a modern IDE.
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/5ce98723-2941-4bf4-adc4-714ea0c860b8" />

### Autocompletion
Bracket and quote autopairs courtesy of [nvim-autopairs](https://github.com/windwp/nvim-autopairs) — never manually close a bracket again.

### Built-in Help Panel
Press `Space h` at any time to open a floating keybind reference panel. Press `Esc` to close it.
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/13dcdb44-524b-46ee-84da-3fbcc123d265" />


### Clean Statusline
A minimal statusline via [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) showing mode, filename, filetype, and cursor position.

### Theme
[Kanagawa Wave](https://github.com/rebelot/kanagawa.nvim) with a custom dark space-grey background (`#1e2127`).

---

## Keybinds

### Dashboard
| Key | Action |
|-----|--------|
| `↑` / `↓` or `j` / `k` | Navigate menu |
| `Enter` | Select item |
| `o` | Open file |
| `r` | Recent files |
| `n` | New file |
| `f` | Find in files |
| `s` | Open settings |
| `q` | Quit |

### Files
| Key | Action |
|-----|--------|
| `Space o` | Open file picker |
| `Space r` | Recent files |
| `Space n` | New file |
| `Space f` | Search text in project |

### Editor
| Key | Action |
|-----|--------|
| `i` | Enter insert mode (start typing) |
| `Esc` | Back to normal mode |
| `:w` | Save file |
| `:q` | Quit |
| `:wq` | Save and quit |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `dd` | Delete line |
| `yy` | Copy line |
| `p` | Paste |
| `gg` / `G` | Top / Bottom of file |
| `w` / `b` | Next / Previous word |

### Splits
| Key | Action |
|-----|--------|
| `Space sv` | Split vertical (side by side) |
| `Space sh` | Split horizontal (top/bottom) |
| `Space sq` | Close split |
| `Space se` | Make splits equal size |
| `Ctrl h/j/k/l` | Move between splits |

### Tabs
| Key | Action |
|-----|--------|
| `Shift l` | Next tab |
| `Shift h` | Previous tab |
| `Space x` | Close tab |
| `Space 1-5` | Jump to tab 1–5 |

### Navigation
| Key | Action |
|-----|--------|
| `Space m` | Return to dashboard (auto-saves first) |
| `Space h` | Open help / keybind panel |

---

## Plugins Used

| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) | Colorscheme |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Tab bar |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto brackets |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons |

---

## License

MIT — do whatever you want with it.
