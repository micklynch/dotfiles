# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with Herdr configuration in this repository.

## Herdr Configuration Overview

[Herdr](https://herdr.dev) is a terminal multiplexer for running multiple AI coding agents side by side. This configuration keeps its keybindings consistent with the Tmux setup in `tmux/`.

## Files

- `config.toml`: Main configuration, deployed to `~/.config/herdr/config.toml`
- `README.md`: Human-facing install and setup instructions

## Key Configuration Features

### Keybindings (`[keys]`)
- **Prefix**: `ctrl+space` (instead of default `ctrl+b`), matching Tmux
- **Tabs**: `shift+left` / `shift+right` for previous / next
- **Workspaces**: `prefix+up` / `prefix+down` for previous / next
- **Splits**: `prefix+|` (vertical), `prefix+minus` (horizontal)
- **Sidebar**: `prefix+m` toggles the sidebar

### UI (`[ui]`)
- `tab_bar_position = "bottom"` (default is top)
- `status_indicators = "symbols"`
- `show_agent_labels_on_pane_borders = false`

### Other
- `onboarding = false` disables the first-run onboarding

## Common Development Tasks

### Apply Configuration
```bash
mkdir -p ~/.config/herdr
cp herdr/config.toml ~/.config/herdr/config.toml
# or symlink so edits stay in the repo
ln -sf "$(pwd)/herdr/config.toml" ~/.config/herdr/config.toml
```
Restart Herdr to pick up changes.

### Verify Installation
```bash
herdr --version
```

### Agent Integrations (optional)
```bash
herdr integration install claude
```

## Guidance for Claude Code

- Read `config.toml` before modifying it; keep the inline comments describing each binding.
- Keep the prefix and split bindings aligned with `tmux/tmux.conf` to preserve muscle memory.
- Only use key and option names documented at https://herdr.dev; do not invent settings.
- When changing bindings or UI options, update the table in `README.md`, this file, and the Herdr section of the root `CLAUDE.md`.
