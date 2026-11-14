# ⚡ Sohel's Neovim Configuration

A clean, modern, blazingly fast Neovim configuration built with Lua, powered by [lazy.nvim](https://github.com/folke/lazy.nvim). Configured for full-stack development, seamless LSP code intelligence, linting, formatting, fuzzy finding, Git integration, and AI assistance with GitHub Copilot.

---

## ✨ Features

- **⚡ Blazing Fast Startup:** Managed by `lazy.nvim` with lazy-loading for instantaneous startup.
- **🎨 Aesthetics:** [Nord](https://github.com/shaunsingh/nord.nvim) theme with background transparency toggle (`<leader>bg`), [Lualine](https://github.com/nvim-lualine/lualine.nvim) statusline, and [Bufferline](https://github.com/akinsho/bufferline.nvim).
- **🧠 Full LSP & Diagnostics:** [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [Mason](https://github.com/williamboman/mason.nvim) for automatic server management (TypeScript, Python, Rust, HTML, CSS, Tailwind, Docker, SQL, Terraform, JSON, YAML, Lua).
- **✨ Formatting & Linting:** [none-ls](https://github.com/nvimtools/none-ls.nvim) with Prettier, Stylua, Ruff, ESLint_d, and shfmt. Auto-formats on save.
- **🔍 Telescope Search:** Fast fuzzy finding for files, grep, buffers, git, and keymaps.
- **📁 File Explorer:** [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) for file navigation, git status tracking, and file management.
- **🌳 Treesitter:** Advanced syntax highlighting, indentation, and incremental selection across dozens of languages.
- **🤖 GitHub Copilot:** [copilot.lua](https://github.com/zbirenbaum/copilot.lua) integration with unobtrusive ghost-text suggestions.
- **🐙 Git Integrated:** [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for diffs and staging hunks + [vim-fugitive](https://github.com/tpope/vim-fugitive).
- **🪄 Quality of Life:** 
  - [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim) for smooth cursor animations.
  - [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) for seamless split & tmux navigation (`<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`).
  - [which-key.nvim](https://github.com/folke/which-key.nvim) for instant keymap discovery.
  - Custom sound effects via `zap_sound.lua`.

---

## 📋 Prerequisites

Before installing, make sure your system has the following installed:

1. **Neovim** (v0.10.0 or higher recommended)
   ```bash
   # macOS (Homebrew)
   brew install neovim

   # Ubuntu / Debian
   sudo snap install --classic nvim
   ```
2. **A Nerd Font** (v3.0+) installed and set in your terminal (e.g. [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads)).
3. **External Dependencies:**
   - `git`
   - `curl`
   - `ripgrep` (required for Telescope live grep)
   - `fd` (recommended for fast file finding)
   - `gcc` / `clang` / `make` (for compiling Treesitter parsers)
   - `node` & `npm` (for Copilot and language servers)
   - `python3` & `pip` (for Python LSP/formatters)

```bash
# macOS
brew install ripgrep fd git curl node python3

# Ubuntu / Debian
sudo apt install ripgrep fd-find git curl nodejs npm python3 python3-pip build-essential
```

---

## 🚀 Installation

### 1. Backup existing Neovim configuration (Recommended)

```bash
# Backup current config and data if you have any
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 2. Clone the repository

```bash
git clone https://github.com/sohelhussain/nvim.git ~/.config/nvim
```

### 3. Launch Neovim

```bash
nvim
```

On first launch, `lazy.nvim` will automatically bootstrap itself and install all plugins.  
`mason-tool-installer` will then download configured Language Servers, linters, and formatters in the background.

> [!TIP]
> Wait a minute for initial installation to complete, then restart Neovim (`:qa` and reopen) for all treesitter parsers and LSP servers to initialize cleanly.

---

## ⌨️ Keybindings

**Leader Key:** `<Space>`

For a complete, comprehensive cheat sheet, see **[NVIM_KEYMAPS.md](NVIM_KEYMAPS.md)**.

### Common Shortcuts

| Mode | Shortcut | Action |
|---|---|---|
| `n` | `<C-s>` | Save file |
| `n` | `<C-q>` | Quit file |
| `n` | `<leader>sn` | Save without auto-formatting |
| `n` | `<leader>e` | Toggle Neo-tree file explorer |
| `n` | `\` | Reveal current file in Neo-tree |
| `n` | `<leader>sf` | Search files (Telescope) |
| `n` | `<leader>sg` | Live grep project text (Telescope) |
| `n` | `<leader><leader>` | Find open buffers |
| `n` | `<Tab>` / `<S-Tab>` | Next / Previous buffer |
| `n` | `<leader>x` | Close buffer without closing split |
| `n` | `<leader>v` / `<leader>h` | Split window vertically / horizontally |
| `n` | `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Navigate windows / tmux panes |
| `n` | `<leader>bg` | Toggle Nord background transparency |

### LSP & Code Intelligence

| Mode | Shortcut | Action |
|---|---|---|
| `n` | `gd` | Go to definition |
| `n` | `gr` | Go to references |
| `n` | `gI` | Go to implementation |
| `n` | `K` | Hover documentation |
| `n` | `<leader>rn` | Rename symbol across workspace |
| `n` | `<leader>ca` | Code action |
| `n` | `<leader>cf` | Format document (LSP / none-ls) |
| `n` | `[d` / `]d` | Previous / Next diagnostic issue |

### GitHub Copilot

| Mode | Shortcut | Action |
|---|---|---|
| `i` | `<M-l>` (`Option + l` or `Alt + l`) | Accept Copilot suggestion |
| `i` | `<M-]>` | Next Copilot suggestion |
| `i` | `<M-[>` | Previous Copilot suggestion |
| `i` | `<C-]>` | Dismiss suggestion |

---

## 📂 Project Structure

```text
~/.config/nvim
├── init.lua                   # Entrypoint & lazy.nvim setup
├── README.md                  # Project documentation
├── NVIM_KEYMAPS.md            # Comprehensive keymap reference
├── NVIM_CHANGELOG.md          # Detailed change history
├── NVIM_AUDIT.md              # Healthcheck & audit notes
└── lua/
    ├── core/
    │   ├── options.lua        # General editor options & settings
    │   ├── keymaps.lua        # Core keymappings
    │   ├── snippets.lua       # Diagnostic styling & snippets
    │   └── zap_sound.lua      # Audio synthesis effects
    └── plugins/
        ├── alpha.lua          # Dashboard startup screen
        ├── autocompletion.lua # nvim-cmp & luasnip
        ├── bufferline.lua     # Buffer tabs on top
        ├── colortheme.lua     # Nord theme & transparency
        ├── comment.lua        # Comment.nvim
        ├── copilot.lua        # GitHub Copilot integration
        ├── gitsigns.lua       # Git gutter signs & hunk actions
        ├── indent-blankline.lua# Indent guides
        ├── lsp.lua            # nvim-lspconfig & Mason setup
        ├── lualine.lua        # Statusline
        ├── misc.lua           # which-key, autopairs, fugitive, tmux
        ├── neotree.lua        # File tree configuration
        ├── none-ls.lua        # Formatters & linters
        ├── smear_cursor.lua   # Animated cursor trail
        ├── telescope.lua      # Fuzzy finder
        └── treesitter.lua     # Tree-sitter syntax highlighting
```

---

## 🛠️ Customization

- **Disable typing sounds:** Comment out or remove `require('core.zap_sound').setup()` in `init.lua`.
- **Add / Remove LSP Servers:** Edit `lua/plugins/lsp.lua` under the `servers` table.
- **Add / Remove Formatters / Linters:** Edit `lua/plugins/none-ls.lua` under `sources` and `ensure_installed`.

---

## 📄 License

Distributed under the MIT License. Feel free to fork, adapt, and use!
