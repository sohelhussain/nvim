# Neovim Keymap Reference

**Leader Key:** `<Space>`  
**Local Leader Key:** `<Space>`  

---

## 1. General & Editing

| Mode | Keymap | Action |
|---|---|---|
| `n` | `<C-s>` | Save file |
| `n` | `<leader>sn` | Save file without auto-formatting (`:noautocmd w`) |
| `n` | `<C-q>` | Quit current file |
| `n` | `<Esc>` | Clear search highlights (`:nohlsearch`) |
| `n` | `x` | Delete character without copying to clipboard (`"_x`) |
| `v` | `p` | Paste over selection without replacing clipboard (`"_dP`) |
| `v` | `<` / `>` | Indent / unindent and retain visual selection |
| `n` | `<C-d>` / `<C-u>` | Scroll down / up and center cursor (`zz`) |
| `n` | `n` / `N` | Repeat search forward / backward and center cursor |
| `n` | `<leader>lw` | Toggle line wrapping |

---

## 2. Window & Split Navigation

| Mode | Keymap | Action |
|---|---|---|
| `n` | `<C-h>` | Navigate to left window / tmux pane (`vim-tmux-navigator`) |
| `n` | `<C-j>` | Navigate to bottom window / tmux pane (`vim-tmux-navigator`) |
| `n` | `<C-k>` | Navigate to top window / tmux pane (`vim-tmux-navigator`) |
| `n` | `<C-l>` | Navigate to right window / tmux pane (`vim-tmux-navigator`) |
| `n` | `<leader>v` | Split window vertically |
| `n` | `<leader>h` | Split window horizontally |
| `n` | `<leader>se` | Equalize window sizes (`<C-w>=`) |
| `n` | `<leader>xs` | Close current split window |
| `n` | `<Up>` / `<Down>` | Resize window vertically (±2 lines) |
| `n` | `<Left>` / `<Right>` | Resize window horizontally (±2 columns) |

---

## 3. Buffers & Tabs

| Mode | Keymap | Action |
|---|---|---|
| `n` | `<Tab>` | Jump to next buffer |
| `n` | `<S-Tab>` | Jump to previous buffer |
| `n` | `<leader>x` | Close active buffer safely without closing window split (`:Bdelete`) |
| `n` | `<leader>b` | Open new empty buffer (`:enew`) |
| `n` | `<leader>to` | Open new tab |
| `n` | `<leader>tx` | Close current tab |
| `n` | `<leader>tn` | Go to next tab |
| `n` | `<leader>tp` | Go to previous tab |

---

## 4. File Explorer (Neo-tree)

| Mode | Keymap | Action |
|---|---|---|
| `n` | `<leader>e` | Toggle Neo-tree file explorer on the left |
| `n` | `\` | Reveal current file in Neo-tree |
| `n` | `<leader>ngs` | Open Neo-tree floating Git status |
| `Neo-tree` | `a` | Add new file (supports bash brace expansion) |
| `Neo-tree` | `A` | Add new directory |
| `Neo-tree` | `d` | Delete file / directory |
| `Neo-tree` | `r` | Rename |
| `Neo-tree` | `y` | Copy file path to clipboard |
| `Neo-tree` | `x` | Cut file |
| `Neo-tree` | `p` | Paste file |
| `Neo-tree` | `P` | Toggle floating preview |
| `Neo-tree` | `H` | Toggle hidden / dotfiles |
| `Neo-tree` | `R` | Refresh tree |
| `Neo-tree` | `q` | Close Neo-tree window |

---

## 5. Telescope (Fuzzy Search)

| Mode | Keymap | Action |
|---|---|---|
| `n` | `<leader>sf` | Search files (respects `.gitignore`, includes hidden) |
| `n` | `<leader>gf` | Search Git files |
| `n` | `<leader>sg` | Live grep project text (requires `ripgrep`) |
| `n` | `<leader>sw` | Grep current word under cursor |
| `n` | `<leader><leader>` | Find existing buffers |
| `n` | `<leader>s.` | Find recent / old files |
| `n` | `<leader>sh` | Search help tags |
| `n` | `<leader>sk` | Search registered keymaps |
| `n` | `<leader>sd` | Search workspace diagnostics |
| `n` | `<leader>sr` | Resume previous Telescope picker |
| `n` | `<leader>/` | Fuzzily search inside current buffer |
| `n` | `<leader>s/` | Live grep inside open buffers |

---

## 6. LSP & Code Intelligence

| Mode | Keymap | Action |
|---|---|---|
| `n` | `gd` | Go to Definition (Telescope) |
| `n` | `gr` | Go to References (Telescope) |
| `n` | `gI` | Go to Implementation (Telescope) |
| `n` | `gD` | Go to Declaration |
| `n` | `K` | Show hover documentation |
| `n` | `<leader>D` | Go to Type Definition |
| `n` | `<leader>ds` | Document Symbols fuzzy search |
| `n` | `<leader>ws` | Workspace Symbols fuzzy search |
| `n` | `<leader>rn` | Rename symbol across project |
| `n` | `<leader>ca` | Code Action (fix, import, refactor) |
| `n` | `<leader>cf` | Format code manually via LSP |
| `n` | `<leader>th` | Toggle inlay hints (if server supports) |

---

## 7. Diagnostics & Quickfix

| Mode | Keymap | Action |
|---|---|---|
| `n` | `[d` | Jump to previous diagnostic |
| `n` | `]d` | Jump to next diagnostic |
| `n` | `<leader>d` | Open floating diagnostic window for current line |
| `n` | `<leader>q` | Populate location list with buffer diagnostics |
| `n` | `[q` | Jump to previous item in quickfix list |
| `n` | `]q` | Jump to next item in quickfix list |
| `n` | `<leader>co` | Open quickfix window |
| `n` | `<leader>cc` | Close quickfix window |

---

## 8. Git Integration (Gitsigns & Fugitive)

| Mode | Keymap | Action |
|---|---|---|
| `n` | `]c` | Jump to next Git change / hunk |
| `n` | `[c` | Jump to previous Git change / hunk |
| `n`, `v` | `<leader>hs` | Stage current hunk / visual selection |
| `n`, `v` | `<leader>hr` | Reset current hunk / visual selection |
| `n` | `<leader>hS` | Stage entire buffer |
| `n` | `<leader>hu` | Undo stage hunk |
| `n` | `<leader>hR` | Reset entire buffer |
| `n` | `<leader>hp` | Preview hunk in popup |
| `n` | `<leader>hb` | Blame line with commit details |
| `n` | `<leader>tb` | Toggle current-line inline blame |
| `n` | `<leader>hd` | Diff against Git index |
| `n` | `<leader>hD` | Diff against last commit (`@`) |
| `n` | `<leader>td` | Toggle display of deleted lines |
| `o`, `x` | `ih` | Inner hunk text object (`vih` to select, `dih` to delete) |

---

## 9. Autocompletion & AI

| Mode | Keymap | Action |
|---|---|---|
| `i` | `<C-n>` / `<C-p>` | Select next / previous completion item |
| `i` | `<C-b>` / `<C-f>` | Scroll documentation window up / down |
| `i` | `<C-y>` | Confirm completion |
| `i` | `<Tab>` | Select next completion item or jump snippet forward |
| `i` | `<S-Tab>` | Select previous completion item or jump snippet backward |
| `i`, `s` | `<C-l>` / `<C-h>` | Jump forward / backward in snippet |
| `i` | `<C-Space>` | Manually trigger completion menu |
| `i` | `<M-l>` | Accept GitHub Copilot suggestion |
| `i` | `<M-]>` / `<M-[>` | Next / previous Copilot suggestion |
| `i` | `<C-]>` | Dismiss Copilot suggestion |

---

## 10. Code Comments & Visual Treesitter

| Mode | Keymap | Action |
|---|---|---|
| `n` | `gcc` | Toggle line comment (`Comment.nvim`) |
| `v` | `gc` | Toggle selection comment (`Comment.nvim`) |
| `n`, `v` | `<C-/>` / `<C-_>` | Toggle comment (standard IDE shortcut) |
| `n`, `v` | `<C-c>` | Toggle comment |
| `n` | `<C-space>` | Initialize Treesitter incremental selection |
| `v` | `<C-space>` | Expand incremental selection to parent node |
| `v` | `<bs>` | Shrink incremental selection to child node |

---

## 11. Terminal & Utilities

| Mode | Keymap | Action |
|---|---|---|
| `n` | `<leader>ft` | Open horizontal terminal split and enter insert mode |
| `t` | `<Esc><Esc>` | Exit terminal mode to normal mode |
| `n` | `<leader>bg` | Toggle Nord background transparency |
| `n` | `<leader>sm` | Toggle smear cursor effect |
