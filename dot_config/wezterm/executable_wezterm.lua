-- WezTerm Configuration with modal.wezterm plugin
-- Optimized for Logitech K680 non-split keyboard ergonomics
-- CapsLock remapped to ESC + Left Control via Karabiner-Elements
-- Goal: Keep hands on home row, minimize palm lifting

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- ============================================
-- LOAD MODAL PLUGIN
-- ============================================
local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")

-- Apply modal plugin and set default keys
modal.apply_to_config(config)
modal.set_default_keys(config)
-- This enables: ALT+u (UI mode), ALT+c (Copy mode), ALT+n (Scroll mode)
-- ESC or CTRL+c to exit any mode

-- ============================================
-- APPEARANCE
-- ============================================
config.color_scheme = "Tokyo Night"
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 14.0
config.line_height = 1.1

-- Window settings
config.window_padding = { left = 10, right = 10, top = 10, bottom = 10 }
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95

-- Tab bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- ============================================
-- LEADER KEY CONFIGURATION
-- ============================================
-- CTRL+A as leader (tmux-style)
-- With CapsLock mapped to Control, press: CapsLock + A
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

-- ============================================
-- KEY BINDINGS
-- ============================================
config.keys = {
  -- ==========================================
  -- LEADER KEY BINDINGS (CTRL+A, then key)
  -- With CapsLock = Control: CapsLock+A, then key
  -- ==========================================
  
  -- Send actual CTRL+A to terminal (double-tap: CTRL+A, CTRL+A)
  { key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
  
  -- PANE NAVIGATION (Leader + hjkl)
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  
  -- PANE SPLITTING
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  
  -- PANE MANAGEMENT
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "Space", mods = "LEADER", action = act.RotatePanes("Clockwise") },
  { key = "o", mods = "LEADER", action = act.RotatePanes("CounterClockwise") },
  { key = "w", mods = "LEADER", action = act.PaneSelect({ mode = "SwapWithActive" }) },
  
  -- PANE RESIZING (Leader + Shift + hjkl)
  { key = "H", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "J", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
  { key = "K", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
  { key = "L", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
  
  -- TAB MANAGEMENT
  { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "&", mods = "LEADER|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
  
  -- Direct tab access (Leader + number)
  { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
  { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
  { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
  { key = "4", mods = "LEADER", action = act.ActivateTab(3) },
  { key = "5", mods = "LEADER", action = act.ActivateTab(4) },
  { key = "6", mods = "LEADER", action = act.ActivateTab(5) },
  { key = "7", mods = "LEADER", action = act.ActivateTab(6) },
  { key = "8", mods = "LEADER", action = act.ActivateTab(7) },
  { key = "9", mods = "LEADER", action = act.ActivateTab(-1) }, -- Last tab
  
  -- COPY MODE & SEARCH
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
  { key = "/", mods = "LEADER", action = act.Search({ CaseSensitiveString = "" }) },
  { key = "s", mods = "LEADER", action = act.QuickSelect },
  
  -- SCROLLBACK (Leader-based to avoid conflicts with apps like Helix)
  { key = "u", mods = "LEADER", action = act.ScrollByPage(-0.5) },
  { key = "d", mods = "LEADER", action = act.ScrollByPage(0.5) },
  
  -- MISC
  { key = "r", mods = "LEADER", action = act.ReloadConfiguration },
  { key = ":", mods = "LEADER|SHIFT", action = act.ShowLauncher },
}

-- ============================================
-- MODAL PLUGIN MODES REMINDER
-- ============================================
-- ALT+u = UI Mode (pane/tab management)
--   h/j/k/l = navigate panes
--   H/J/K/L = resize panes
--   -/| = split panes
--   x = close pane
--   c = new tab
--   n/p = next/prev tab
--
-- ALT+c = Copy Mode (vim-style selection)
--   v = start selection
--   y = copy selection
--   hjkl = move cursor
--
-- ALT+n = Scroll Mode
--   j/k = scroll line
--   u/d = scroll half page
--   g/G = top/bottom
--
-- ESC or CTRL+c = exit any mode

return config
