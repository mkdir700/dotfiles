# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Hammerspoon configuration for macOS window management and application switching. Hammerspoon is a macOS automation tool that bridges Lua scripting with macOS APIs for desktop automation, window management, and system control.

## Architecture

### Core Structure
- **`init.lua`**: Main entry point that loads modules and defines global hotkeys
- **`modules/`**: Custom Lua modules for specific functionality
  - `WindowZoom.lua`: Window scaling functionality with center-point zoom
  - `WindowPair.lua`: Advanced window pairing system for automatic layout management
- **`Spoons/`**: Third-party Hammerspoon extensions (Spoons)
  - `EmmyLua.spoon/`: Lua language server annotations for IDE support

### Key Components

**Application Launcher System** (init.lua:31-45):
- Global hotkey bindings using `ctrl+alt+cmd+shift` modifier combination
- Predefined application mappings for common apps (ChatGPT, WeChat, VSCode, Finder, Chrome, Obsidian)
- Smart launch-or-focus logic that activates running apps or launches new instances

**Window Zoom Module** (modules/WindowZoom.lua):
- Provides `zoomIn()` and `zoomOut()` functions bound to `Cmd+=` and `Cmd+-`
- Center-point scaling with screen boundary constraints
- 10% scale increments configurable via `scaleStep` variable

**Window Pairing System** (modules/WindowPair.lua):
- Advanced window relationship management with automatic layout synchronization
- Configurable pairing rules in `PAIRS` table (currently empty but supports app-based and title-based matching)
- Multiple layout options: vertical50, vertical66, horizontal50, or custom functions
- Hotkeys for temporary pairing (`Alt+Cmd+P`) and quick screen splitting (`Alt+Cmd+L`)
- Event-driven system using `hs.window.filter` for automatic window management

## Development Commands

### Configuration Management
```bash
# Reload Hammerspoon configuration
# Use hotkey: Ctrl+Alt+Cmd+Shift+R
# Or from Hammerspoon console: hs.reload()
```

### Testing and Development
- **Console Access**: Open Hammerspoon.app → Console for interactive Lua REPL
- **Real-time Testing**: Modify `.lua` files and use reload hotkey for immediate testing
- **Logging**: Uses `hs.printf()` for debug output visible in console
- **Error Handling**: `xpcall()` with `debug.traceback` for error reporting in WindowPair module

### Configuration Files
- **`.luarc.json`**: Lua language server configuration defining `hs` as global
- **`.config`**: Hammerspoon module configuration (legacy format, modules referenced are not present)

## Module Development Patterns

### Module Structure
All custom modules follow this pattern:
```lua
local M = {}
-- Module implementation
function M.publicFunction()
  -- Implementation
end
return M
```

### Event Handling
- Use `hs.window.filter` for window event monitoring
- Implement guard functions (`withGuard`) to prevent event recursion
- Handle window validity with `hs.window.get()` for cross-version compatibility

### Window Operations
- Always check window validity with custom `valid()` functions
- Use `isStandard()` and `isMinimized()` for filtering appropriate windows
- Prefer `moveToScreen()` with animation parameters for smooth transitions

## Hotkey Bindings

### Global Application Switching
- `Ctrl+Alt+Cmd+Shift+A`: ChatGPT
- `Ctrl+Alt+Cmd+Shift+W`: WeChat  
- `Ctrl+Alt+Cmd+Shift+V`: VSCode
- `Ctrl+Alt+Cmd+Shift+E`: Finder
- `Ctrl+Alt+Cmd+Shift+C`: Chrome
- `Ctrl+Alt+Cmd+Shift+N`: Obsidian

### Window Management
- `Cmd+=`: Zoom in current window
- `Cmd+-`: Zoom out current window
- `Alt+Cmd+P`: Toggle temporary window pairing
- `Alt+Cmd+L`: Quick split current screen
- `Ctrl+Alt+Cmd+Shift+R`: Reload Hammerspoon configuration

## Customization

### Adding New Applications
Modify the `applications` table in `init.lua`:
```lua
{ prefix = { "ctrl", "alt", "cmd", "shift" }, key = "X", message = "App Name", bundleId = "com.example.app" }
```

### Configuring Window Pairs
Edit the `PAIRS` table in `modules/WindowPair.lua`:
```lua
{ a = { app = "App1" }, b = { app = "App2" }, layout = "vertical50" }
```

### Layout Customization
- Built-in layouts: `vertical50`, `vertical66`, `horizontal50`
- Custom layouts: Define functions with signature `(winA, winB, screen)`
- Modify zoom scale: Change `scaleStep` in `WindowZoom.lua`