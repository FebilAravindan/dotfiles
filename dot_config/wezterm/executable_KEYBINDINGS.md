# WezTerm Keybindings Reference

## Ergonomic Configuration for Logitech K680
Keep hands on home row, minimize palm lifting.

---

## Leader Key: `CTRL + A`

Press `CTRL+A`, release, then press the action key within 1 second.

**To send actual CTRL+A to shell:** Double-tap `CTRL+A, CTRL+A`

---

## Pane Management

### Creating Panes (Splitting)

| Keys | Action |
|------|--------|
| `CTRL+A` then `-` | Split vertically (top/bottom) |
| `CTRL+A` then `\|` | Split horizontally (left/right) |

### Navigating Panes

| Keys | Action |
|------|--------|
| `CTRL+A` then `h` | Move to left pane |
| `CTRL+A` then `j` | Move to pane below |
| `CTRL+A` then `k` | Move to pane above |
| `CTRL+A` then `l` | Move to right pane |

### Resizing Panes

| Keys | Action |
|------|--------|
| `CTRL+A` then `H` | Resize left (Shift+h) |
| `CTRL+A` then `J` | Resize down (Shift+j) |
| `CTRL+A` then `K` | Resize up (Shift+k) |
| `CTRL+A` then `L` | Resize right (Shift+l) |

### Pane Actions

| Keys | Action |
|------|--------|
| `CTRL+A` then `z` | Toggle zoom (maximize pane) |
| `CTRL+A` then `x` | Close current pane |

---

## Tab Management

### Creating & Closing Tabs

| Keys | Action |
|------|--------|
| `CTRL+A` then `c` | Create new tab |
| `CTRL+A` then `&` | Close current tab (Shift+7) |

### Navigating Tabs

| Keys | Action |
|------|--------|
| `CTRL+A` then `n` | Next tab |
| `CTRL+A` then `p` | Previous tab |
| `CTRL+A` then `1` | Go to tab 1 |
| `CTRL+A` then `2` | Go to tab 2 |
| `CTRL+A` then `3` | Go to tab 3 |
| `CTRL+A` then `4` | Go to tab 4 |
| `CTRL+A` then `5` | Go to tab 5 |
| `CTRL+A` then `6` | Go to tab 6 |
| `CTRL+A` then `7` | Go to tab 7 |
| `CTRL+A` then `8` | Go to tab 8 |
| `CTRL+A` then `9` | Go to last tab |

---

## Modal Modes (modal.wezterm plugin)

### Entering Modes

| Keys | Mode | Description |
|------|------|-------------|
| `ALT + u` | UI Mode | Pane/tab management with single keys |
| `ALT + c` | Copy Mode | Vim-like text selection |
| `ALT + n` | Scroll Mode | Scroll with vim keys |
| `ESC` | — | Exit any mode |

### UI Mode Keys (after `ALT+u`)

| Key | Action |
|-----|--------|
| `h/j/k/l` | Navigate panes |
| `H/J/K/L` | Resize panes |
| `s` | Split horizontal |
| `v` | Split vertical |
| `x` | Close pane |
| `c` | New tab |
| `n/p` | Next/prev tab |
| `1-9` | Switch to tab |
| `ESC` | Exit UI mode |

### Copy Mode Keys (after `ALT+c`)

| Key | Action |
|-----|--------|
| `h/j/k/l` | Move cursor |
| `w/b/e` | Move by word |
| `0/$` | Start/end of line |
| `g/G` | Top/bottom of scrollback |
| `v` | Start selection |
| `V` | Line selection |
| `y` | Copy selection |
| `/` | Search forward |
| `?` | Search backward |
| `n/N` | Next/prev match |
| `ESC` | Exit copy mode |

### Scroll Mode Keys (after `ALT+n`)

| Key | Action |
|-----|--------|
| `j/k` | Scroll down/up |
| `d/u` | Half page down/up |
| `f/b` | Full page down/up |
| `g/G` | Top/bottom |
| `ESC` | Exit scroll mode |

---

## Scrollback Navigation

| Keys | Action |
|------|--------|
| `CTRL+SHIFT+u` | Scroll up half page |
| `CTRL+SHIFT+d` | Scroll down half page |
| `CTRL+A` then `[` | Enter copy mode |
| `CTRL+A` then `/` | Search scrollback |

---

## Copy & Selection

| Keys | Action |
|------|--------|
| `CTRL+A` then `[` | Enter copy mode |
| `CTRL+A` then `s` | Quick select (URLs, paths, hashes) |
| `CTRL+SHIFT+c` | Copy selection |
| `CTRL+SHIFT+v` | Paste from clipboard |

---

## Window & Display

| Keys | Action |
|------|--------|
| `ALT + Enter` | Toggle fullscreen |
| `CTRL + =` | Increase font size |
| `CTRL + -` | Decrease font size |
| `CTRL + 0` | Reset font size |

---

## Utilities

| Keys | Action |
|------|--------|
| `CTRL+A` then `r` | Reload configuration |
| `CTRL+A` then `d` | Show debug overlay |
| `CTRL+A` then `CTRL+A` | Send CTRL+A to terminal |

---

## Quick Workflows

### Split into 3-pane layout (editor + server + shell)
```
CTRL+A, |     → Split horizontal (editor | right)
CTRL+A, l     → Move to right pane
CTRL+A, -     → Split vertical (server / shell)
CTRL+A, h     → Back to editor
```

### Create project workspace
```
CTRL+A, c     → New tab (tab 1: code)
CTRL+A, c     → New tab (tab 2: server)
CTRL+A, c     → New tab (tab 3: git)
CTRL+A, 1     → Go to tab 1
```

### Copy text from scrollback
```
ALT+c         → Enter copy mode
k/j           → Navigate up/down
v             → Start selection
y             → Copy and exit
CTRL+SHIFT+v  → Paste
```

---

## Configuration File

```
~/.config/wezterm/wezterm.lua
```

## Troubleshooting

```bash
# Show all key assignments
wezterm show-keys --lua

# Debug key events (add to config)
config.debug_key_events = true

# Check logs
ls ~/.local/share/wezterm/
```
