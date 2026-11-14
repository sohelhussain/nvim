# Neovim Configuration Changelog

This document tracks all modifications made during the audit and upgrade.

---

### `lua/core/options.lua`
- **Changed:** Switched `vim.wo.number` to `vim.opt.number` and `vim.wo.signcolumn` to `vim.opt.signcolumn`.
  - *Reason:* `vim.wo` applies only to the initial window at startup, failing on subsequent splits. `vim.opt` provides persistent defaults.
- **Added:** `FileType` autocommand to remove `formatoptions` flags (`c`, `r`, `o`) on file open.
  - *Reason:* Filetype plugins override `formatoptions` set globally; the autocommand guarantees comments do not auto-continue on `<CR>` or `o`.

### `lua/core/keymaps.lua`
- **Added:** `<Esc>` in Normal mode mapped to `:nohlsearch<CR>`.
  - *Reason:* Provides a fast and intuitive way to clear search highlights.
- **Updated:** `<leader>x` mapped to use `:Bdelete` (`vim-bbye`) with fallback to `:bdelete`.
  - *Reason:* Prevented window splits and layouts from collapsing when closing a buffer.
- **Removed:** Standalone `<C-h>` mapped to `:wincmd h<CR>`.
  - *Reason:* Interfered with `christoomey/vim-tmux-navigator` (which manages `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` seamlessly across Vim and tmux).
- **Added:** Quickfix navigation keymaps (`[q`, `]q`, `<leader>co`, `<leader>cc`).
  - *Reason:* Enables direct jumping through compiler and search results.
- **Updated:** Diagnostic navigation `[d` and `]d` to support Neovim 0.11's `vim.diagnostic.jump()`.
  - *Reason:* Prevents deprecation warnings and provides smoother diagnostic cycling.
- **Added:** Terminal mode exit mapping `<Esc><Esc>` to `<C-\><C-n>`.
  - *Reason:* Avoids getting trapped in terminal buffers created via `<leader>ft`.

### `lua/core/snippets.lua`
- **Updated:** `vim.highlight` calls changed to `(vim.hl or vim.highlight)`.
  - *Reason:* Deprecation notice in Neovim 0.11/0.12 where `vim.highlight` is moved to `vim.hl`.
- **Added:** Centralized diagnostic sign definitions in `vim.diagnostic.config { signs = { ... } }`.
  - *Reason:* Modern Neovim 0.10+ standard replacing deprecated `vim.fn.sign_define`.
- **Updated:** Diagnostic background transparency hook attached to `ColorScheme` autocmd instead of invalid `on_ready` field.

### `lua/plugins/neotree.lua`
- **Removed:** Legacy `vim.fn.sign_define` calls for `DiagnosticSign*`.
  - *Reason:* Replaced by the native diagnostic signs table in `snippets.lua`.

### `lua/plugins/lsp.lua`
- **Added:** Manual code formatting mapping `<leader>cf` and hover documentation `K` to `LspAttach`.
  - *Reason:* Allows on-demand formatting and symbol documentation without needing an auto-format trigger.
- **Fixed:** `mason-lspconfig` handler guarded against non-LSP packages (`stylua`) and unconfigured servers.
  - *Reason:* Mason-lspconfig was attempting to run `require('lspconfig').stylua.setup()`, producing `[lspconfig] config 'stylua' not found`.
- **Optimized:** `lua_ls` workspace library settings updated to reference `vim.env.VIMRUNTIME` instead of calling `unpack(vim.api.nvim_get_runtime_file('', true))`.
  - *Reason:* Prevents slow indexing of all installed plugin directories on startup.

### `lua/plugins/none-ls.lua`
- **Fixed:** Conditionally registered `formatting.terraform_fmt` only when `terraform` executable is installed.
  - *Reason:* Eliminated `terraform_fmt: command not executable` error during healthchecks.
- **Added:** `eslint_d` diagnostics support from `none-ls-extras` with automatic root config detection (`.eslintrc.*`, `eslint.config.*`).
  - *Reason:* `eslint_d` was installed by Mason but was never hooked into `sources`.
- **Updated:** Scoped write-formatting `BufWritePre` autocommand to `filter = function(c) return c.name == 'null-ls' end` with a 3000ms timeout.
  - *Reason:* Prevents race conditions and multiple formatters fighting when other language servers attach.

### `lua/plugins/comment.lua`
- **Fixed:** Added `require('Comment').setup(opts)` inside `config`.
  - *Reason:* Providing a custom `config` function without calling `.setup()` disabled native `Comment.nvim` mappings (`gcc`, `gc`).

### `lua/plugins/misc.lua`
- **Fixed:** Configured `folke/which-key.nvim` with `event = 'VimEnter'` and group descriptions.
  - *Reason:* The plugin was loaded but unconfigured, failing to show popup keybinding guides.

### `lua/plugins/gitsigns.lua`
- **Added:** Complete `on_attach` callback containing keymaps for hunk navigation (`]c`, `[c`), staging (`<leader>hs`, `<leader>hS`), resetting (`<leader>hr`, `<leader>hR`), previewing (`<leader>hp`), inline blame (`<leader>hb`), line blame toggle (`<leader>tb`), diffing (`<leader>hd`, `<leader>hD`), and text object (`ih`).
  - *Reason:* Gitsigns only had static sign gutter indicators without any interactive capabilities.

### `lua/plugins/treesitter.lua`
- **Added:** `incremental_selection` configured with `<C-space>` and `<bs>`.
  - *Reason:* Re-enabled intelligent syntactic block expansion.

### `lua/plugins/copilot.lua`
- **Updated:** Configured `auto_trigger = true`, debounce, and explicit keys for `suggestion` (`<M-l>` accept, `<M-]>` next, `<M-[>` prev, `<C-]>` dismiss).
  - *Reason:* Ensures Copilot suggestions render reliably without interfering with Tab or snippets.

### `lua/plugins/telescope.lua`
- **Added:** `<leader>gf` for `builtin.git_files`.
- **Added:** Safe fallback with notification for `builtin.live_grep` when `ripgrep` (`rg`) is not installed.
  - *Reason:* Prevents crashes when searching strings without host `rg`.
