# Git Configuration

This directory contains Git configuration files optimized for a modern development workflow.

## Files

- `gitconfig` - Main Git configuration file with sensible defaults and custom aliases

## Features

### Core Configuration
- **Default branch**: `main` (instead of `master`)
- **Pull strategy**: `rebase` (maintains linear history)
- **Auto-stash**: Automatically stashes changes during rebase operations
- **Fetch pruning**: Automatically removes stale remote-tracking branches
- **Diff coloring**: Enhanced diff with `zebra` color mode for moved lines

### Merge & Diff Tools
- **Merge tool**: `nvimdiff` (Neovim as merge tool)
- **Diff tool**: `nvimdiff` (Neovim as diff viewer)
- **Non-prompting**: Difftool runs without confirmation prompts

### Custom Aliases
- `git s` - Quick diff comparison with previous commit (`HEAD^` vs `HEAD`)

## Installation

1. Copy the configuration file to your home directory:
   ```bash
   cp gitconfig ~/.gitconfig
   ```

2. Alternatively, merge the contents with your existing `~/.gitconfig` file.

## Configuration Details

### Rebase Workflow
The configuration is optimized for a rebase-based workflow:
- `pull.rebase = true` - Always rebase when pulling
- `rebase.autoStash = true` - Automatically stash local changes during rebase

### Enhanced Diff Display
- `diff.colorMoved = zebra` - Highlights moved code blocks with alternating colors
- `fetch.prune = true` - Removes references to deleted remote branches

### Neovim Integration
- Uses Neovim for both merge and diff operations
- Configures proper command-line arguments for side-by-side comparison

## Compatibility

This configuration works with:
- Git 2.0+
- Neovim (for merge/diff operations)
- Any terminal that supports ANSI color codes