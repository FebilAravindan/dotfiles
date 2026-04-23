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
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

-- Apply modal plugin and set default keys
modal.apply_to_config(config)
modal.set_default_keys(config)
-- This enables: ALT+u (UI mode), ALT+c (Copy mode), ALT+n (Scroll mode)
-- ESC or CTRL+c to exit any mode

-- ============================================
-- RESURRECT PLUGIN (session persistence)
-- ============================================
-- Auto-save workspace state every 15 minutes
resurrect.state_manager.periodic_save({
  interval_seconds = 15 * 60,
  save_workspaces = true,
  save_windows = true,
  save_tabs = true,
})

-- Event listeners for save/load notifications
wezterm.on("resurrect.error", function(error)
  wezterm.log_error("Resurrect error: " .. error)
end)

-- ============================================
-- APPEARANCE
-- ============================================
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
  { family = "JetBrains Mono", weight = "Medium" },
  {
    family = "Noto Sans Malayalam",  -- Malayalam script support
    harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
  },
  "Noto Color Emoji",      -- Emoji fallback
})
config.font_size = 14.0
config.line_height = 1.1

-- Allow Malayalam combined glyphs (wider than monospace cell) to overflow
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"

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

  -- SESSION MANAGEMENT (resurrect.wezterm)
  -- Save current workspace state
  { key = "S", mods = "LEADER|SHIFT", action = wezterm.action_callback(function(win, pane)
    resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
    resurrect.window_state.save_window_action()
  end) },
  -- Fuzzy-load a saved workspace/window/tab
  { key = "R", mods = "LEADER|SHIFT", action = wezterm.action_callback(function(win, pane)
    resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
      local type = string.match(id, "^([^/]+)")
      id = string.match(id, "([^/]+)$")
      id = string.match(id, "(.+)%..+$")
      local opts = {
        relative = true,
        restore_text = true,
        on_pane_restore = resurrect.tab_state.default_on_pane_restore,
      }
      if type == "workspace" then
        local state = resurrect.state_manager.load_state(id, "workspace")
        resurrect.workspace_state.restore_workspace(state, opts)
      elseif type == "window" then
        local state = resurrect.state_manager.load_state(id, "window")
        resurrect.window_state.restore_window(pane:window(), state, opts)
      elseif type == "tab" then
        local state = resurrect.state_manager.load_state(id, "tab")
        resurrect.tab_state.restore_tab(pane:tab(), state, opts)
      end
    end)
  end) },
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
