# Repository Guidelines

## Project Structure & Module Organization
This repository manages personal dotfiles with **chezmoi**. Top-level files map to home-directory targets using chezmoi naming:
- `dot_zshrc.tmpl`: templated `~/.zshrc` (OS-specific logic via chezmoi template blocks).
- `dot_hammerspoon/`: Hammerspoon config (`init.lua`, `modules/*.lua`, `images/`, bundled `Spoons/`).
- `dot_config/`: XDG-style app configs (`private_fish/`, `private_karabiner/`, `yabai/`, `skhd/`, `zed/`, etc.).
- `dot_tmux/`, `dot_ideavimrc`: terminal/editor config entry points.

## Build, Test, and Development Commands
Use chezmoi commands from this repo as source state:
- `chezmoi diff --source ~/.local/share/chezmoi`: preview pending local changes.
- `chezmoi apply --source ~/.local/share/chezmoi`: apply dotfiles to `$HOME`.
- `chezmoi edit ~/.zshrc` (or target file): edit via chezmoi while preserving mappings.
- `chezmoi doctor`: verify chezmoi/tooling health.
- `lua -p dot_hammerspoon/init.lua`: quick syntax check for Lua config edits.

## Coding Style & Naming Conventions
- Keep existing indentation per file: Lua uses tabs in current Hammerspoon modules; shell/fish scripts generally use spaces.
- Follow chezmoi naming: `dot_*` for dotfiles, `private_*` for sensitive/private paths, and `.tmpl` for template-rendered files.
- Prefer small, focused modules under `dot_hammerspoon/modules/` instead of large `init.lua` additions.
- Keep comments short and actionable; avoid restating obvious code.

## Testing Guidelines
No formal automated test suite is present. Validate changes by type:
- Shell/Fish: run `zsh -n dot_zshrc.tmpl` and `fish -n dot_config/private_fish/config.fish`.
- Hammerspoon: `lua -p` checks plus reload Hammerspoon and confirm hotkeys/modules load.
- Chezmoi: always run `chezmoi diff` before `chezmoi apply` to avoid unintended file drift.

## Commit & Pull Request Guidelines
Git history favors short imperative messages (`Add ...`, `Update ...`). Use concise, scope-first commits, e.g.:
- `Add zed keymap config`
- `Update hammerspoon window bindings`

For PRs, include:
- What changed and why.
- Affected paths (example: `dot_hammerspoon/modules/window.lua`).
- Manual verification steps and results.
- Screenshots/GIFs only when UI behavior (Hammerspoon overlays/menus) changes.
