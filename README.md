# Sohel's Neovim Configuration

A Neovim config written in Lua and managed with [lazy.nvim](https://github.com/folke/lazy.nvim). It is set up for full-stack work: LSP, formatting and linting, fuzzy finding, Git, and GitHub Copilot.

## Features

- **Startup:** Plugins are lazy-loaded through `lazy.nvim`.
- **Appearance:** [Nord](https://github.com/shaunsingh/nord.nvim) theme with a transparency toggle (`<leader>bg`), [Lualine](https://github.com/nvim-lualine/lualine.nvim) statusline and [Bufferline](https://github.com/akinsho/bufferline.nvim) tabs.
- **LSP and diagnostics:** [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) with [Mason](https://github.com/williamboman/mason.nvim) installing the servers. Covers TypeScript, Python, Rust, HTML, CSS, Tailwind, Docker, SQL, Terraform, JSON, YAML and Lua.
- **Formatting and linting:** [none-ls](https://github.com/nvimtools/none-ls.nvim) with Prettier, Stylua, Ruff, ESLint_d and shfmt. Files are formatted on save.
- **Search:** Telescope for files, grep, buffers, git and keymaps.
- **File explorer:** [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) with git status.
- **Syntax:** Treesitter highlighting, indentation and incremental selection.
- **Copilot:** [copilot.lua](https://github.com/zbirenbaum/copilot.lua) with ghost-text suggestions.
- **Git:** [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for diffs and hunk staging, plus [vim-fugitive](https://github.com/tpope/vim-fugitive).
- **Extras:**
  - [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim) for cursor animation.
  - [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) for moving between Neovim splits and tmux panes with `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`.
  - [which-key.nvim](https://github.com/folke/which-key.nvim) for keymap hints.
  - Sound effects via `zap_sound.lua`.

## Prerequisites

1. **Neovim** 0.10.0 or higher.

   ```bash
   # macOS
   brew install neovim

   # Ubuntu / Debian
   sudo snap install --classic nvim
   ```

2. **A Nerd Font** (v3.0+) set as your terminal font, for example [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads).

3. **External tools:**
   - `git` and `curl`
   - `ripgrep` (needed for Telescope live grep)
   - `fd` (faster file finding)
   - `gcc`, `clang` or `make` (to compile Treesitter parsers)
   - `node` and `npm` (Copilot and some language servers)
   - `python3` and `pip` (Python LSP and formatters)

   ```bash
   # macOS
   brew install ripgrep fd git curl node python3

   # Ubuntu / Debian
   sudo apt install ripgrep fd-find git curl nodejs npm python3 python3-pip build-essential
   ```

   On Ubuntu and Debian the `fd` binary is installed as `fdfind`. Link it so Telescope can find it:

   ```bash
   mkdir -p ~/.local/bin
   ln -s "$(which fdfind)" ~/.local/bin/fd
   ```

## Installation

### 1. Back up your existing config (optional)

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

Any of these that don't exist will print an error. You can ignore it.

### 2. Clone the repo

```bash
git clone https://github.com/sohelhussain/nvim.git ~/.config/nvim
```

### 3. Start Neovim

```bash
nvim
```

On first launch, `lazy.nvim` installs itself and all plugins. `mason-tool-installer` then downloads the language servers, linters and formatters in the background.

> [!TIP]
> Give the installs a minute to finish, then quit (`:qa`) and reopen Neovim so the Treesitter parsers and LSP servers start cleanly.

### 4. tmux setup (optional)

`vim-tmux-navigator` needs a matching setup on the tmux side, otherwise `<C-h/j/k/l>` only moves between Neovim splits. Follow the [plugin's README](https://github.com/christoomey/vim-tmux-navigator#tmux) to add it to `~/.tmux.conf`.

## Keybindings

The leader key is `<Space>`. The full list is in [NVIM_KEYMAPS.md](NVIM_KEYMAPS.md).

### General

| Mode | Shortcut | Action |
|---|---|---|
| `n` | `<C-s>` | Save file |
| `n` | `<C-q>` | Quit file |
| `n` | `<leader>sn` | Save without auto-formatting |
| `n` | `<leader>e` | Toggle Neo-tree |
| `n` | `\` | Reveal current file in Neo-tree |
| `n` | `<leader>sf` | Search files (Telescope) |
| `n` | `<leader>sg` | Live grep (Telescope) |
| `n` | `<leader><leader>` | Find open buffers |
| `n` | `<Tab>` / `<S-Tab>` | Next / previous buffer |
| `n` | `<leader>x` | Close buffer, keep the split |
| `n` | `<leader>v` / `<leader>h` | Split vertically / horizontally |
| `n` | `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Move between windows and tmux panes |
| `n` | `<leader>bg` | Toggle Nord background transparency |

### LSP

| Mode | Shortcut | Action |
|---|---|---|
| `n` | `gd` | Go to definition |
| `n` | `gr` | Go to references |
| `n` | `gI` | Go to implementation |
| `n` | `K` | Hover documentation |
| `n` | `<leader>rn` | Rename symbol |
| `n` | `<leader>ca` | Code action |
| `n` | `<leader>cf` | Format document (LSP / none-ls) |
| `n` | `[d` / `]d` | Previous / next diagnostic |

### GitHub Copilot

| Mode | Shortcut | Action |
|---|---|---|
| `i` | `<M-l>` (`Option + l` on macOS, `Alt + l` elsewhere) | Accept suggestion |
| `i` | `<M-]>` | Next suggestion |
| `i` | `<M-[>` | Previous suggestion |
| `i` | `<C-]>` | Dismiss suggestion |

Run `:Copilot auth` on first use to sign in.

## Project Structure

```text
~/.config/nvim
├── init.lua                    # Entry point and lazy.nvim setup
├── README.md
├── NVIM_KEYMAPS.md             # Full keymap reference
├── NVIM_CHANGELOG.md           # Change history
├── NVIM_AUDIT.md               # Healthcheck and audit notes
└── lua/
    ├── core/
    │   ├── options.lua         # Editor options
    │   ├── keymaps.lua         # Core keymaps
    │   ├── snippets.lua        # Diagnostic styling and snippets
    │   └── zap_sound.lua       # Sound effects
    └── plugins/
        ├── alpha.lua           # Dashboard
        ├── autocompletion.lua  # nvim-cmp and LuaSnip
        ├── bufferline.lua      # Buffer tabs
        ├── colortheme.lua      # Nord theme and transparency
        ├── comment.lua         # Comment.nvim
        ├── copilot.lua         # GitHub Copilot
        ├── gitsigns.lua        # Git signs and hunk actions
        ├── indent-blankline.lua # Indent guides
        ├── lsp.lua             # nvim-lspconfig and Mason
        ├── lualine.lua         # Statusline
        ├── misc.lua            # which-key, autopairs, fugitive, tmux
        ├── neotree.lua         # File tree
        ├── none-ls.lua         # Formatters and linters
        ├── smear_cursor.lua    # Cursor trail
        ├── telescope.lua       # Fuzzy finder
        └── treesitter.lua      # Syntax highlighting
```

## Customization

- **Turn off sound effects:** remove or comment out `require('core.zap_sound').setup()` in `init.lua`.
- **Add or remove LSP servers:** edit the `servers` table in `lua/plugins/lsp.lua`.
- **Add or remove formatters and linters:** edit `sources` and `ensure_installed` in `lua/plugins/none-ls.lua`.

## License

MIT. Fork it and change whatever you like.
