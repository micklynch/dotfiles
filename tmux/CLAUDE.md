# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with Tmux configuration in this repository.

## Tmux Configuration Overview

This Tmux configuration is optimized for terminal-based development with vim-style navigation and modern plugin ecosystem.

## Key Configuration Features

### Custom Prefix Key
- **Prefix**: `Ctrl-Space` (instead of default `Ctrl-b`)
- **Rationale**: More ergonomic and doesn't conflict with window management

### Plugin Ecosystem
- **TPM**: Tmux Plugin Manager for easy plugin installation
- **vim-tmux-navigator**: Seamless vim/tmux pane navigation
- **catppuccin-tmux**: Modern color scheme (mocha flavor)
- **tmux-yank**: Enhanced clipboard integration

### Navigation Philosophy
- **Vim-style consistency**: Uses `h/j/k/l` for pane navigation
- **Mouse support**: Click and drag for pane selection/resizing
- **Base indexing**: Windows and panes start at 1 (more intuitive)

## Common Development Tasks

### Session Management
```bash
# Start new session
tmux

# Detach from session
Ctrl-Space d

# List sessions
tmux ls

# Reattach to session
tmux attach -t <session-name>
```

### Window Management
```bash
# Create new window
Ctrl-Space c

# Rename current window
Ctrl-Space ,

# Switch windows (multiple methods)
Shift + Left/Right          # Arrow keys
Alt + H/L                   # Vim-style without prefix
Ctrl-Space 1/2/3...         # Direct window selection
```

### Pane Management
```bash
# Split panes
Ctrl-Space |    # Vertical split
Ctrl-Space -    # Horizontal split

# Navigate panes
Ctrl-Space h/j/k/l     # With prefix
Alt + Arrow keys        # Without prefix

# Close pane
Ctrl-Space x

# Zoom pane (toggle fullscreen)
Ctrl-Space z
```

### Plugin Management
```bash
# Install plugins
Ctrl-Space I

# Update plugins
Ctrl-Space U

# Uninstall unused plugins
Ctrl-Space alt u
```

## Development Workflow Integration

### With Neovim
The vim-tmux-navigator plugin enables seamless navigation:
- Use `Ctrl-h/j/k/l` to move between vim splits and tmux panes
- No prefix needed when inside vim
- Works automatically with the Neovim configuration in this repository

### Terminal Applications
```bash
# Open multiple terminals for development
Ctrl-Space c    # New window for each task
Ctrl-Space |    # Split for related tasks

# Example layout:
# Window 1: Editor (nvim)
# Window 2: Terminal for running commands
# Window 3: File manager (mc) or logs
```

### Copy-Paste Workflow
```bash
# Enter copy mode
Ctrl-Space [

# Navigate (vim-style)
h/j/k/l    # Move cursor
v          # Start selection
y          # Copy to system clipboard

# Paste in terminal
Ctrl-Space ]    # Or use system paste in modern terminals
```

## Configuration Management

### Applying This Configuration
```bash
# Install TPM first
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Copy configuration
mkdir -p ~/.config/tmux
cp tmux/tmux.conf ~/.config/tmux/tmux.conf

# Source configuration
tmux source ~/.config/tmux/tmux.conf

# Install plugins
tmux
Ctrl-Space I
```

### Verification
```bash
# Check configuration
tmux show-options -g | grep prefix

# Test plugins
tmux list-keys | grep yank

# Verify theme
tmux show-options -g | grep catppuccin
```

## Advanced Usage Patterns

### Development Session Templates
```bash
# Create standardized development session
tmux new -s dev
Ctrl-Space c    # Window 2: Terminal
Ctrl-Space c    # Window 3: Git/logs
Ctrl-Space |    # Split for monitoring
```

### Pair Programming Setup
```bash
# Shared session for pair programming
tmux new -s pair-programming
# Both users attach to same session
tmux attach -t pair-programming
```

### Project-Specific Configurations
Create project-specific tmux sessions:
```bash
tmux new -s project-name
# Set up windows for specific project needs
```

## Integration with Other Tools

### With Midnight Commander
- Open mc in dedicated tmux window
- Use tmux navigation to switch between mc and editor
- Split panes for file operations while coding

### With Git Operations
- Use dedicated window for git operations
- Split panes for git status and editor
- Copy commit hashes between windows

### With Build Processes
- Run build/test commands in separate panes
- Monitor logs while editing code
- Quickly switch between code and output

## Troubleshooting

### Common Issues
- **Prefix not working**: Verify tmux.conf is sourced correctly
- **Plugins not loading**: Ensure TPM is installed and plugins are installed (`Ctrl-Space I`)
- **Colors incorrect**: Check terminal color support (256-color minimum)

### Performance Optimization
- Configuration is optimized for minimal startup impact
- Plugins are chosen for efficiency
- True color support requires compatible terminal

### Keybinding Conflicts
- The `Ctrl-Space` prefix avoids common conflicts
- vim-tmux-navigator handles vim/tmux integration seamlessly
- Mouse support enhances but doesn't replace keyboard workflow

## Customization and Extension

### Adding Custom Commands
```bash
# Add to tmux.conf
bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded"
```

### Project-Specific Sessions
Create scripts for standard project layouts:
```bash
#!/bin/bash
tmux new -s $1 \; \
  send-keys "nvim" C-m \; \
  new-window \; \
  send-keys "ls -la" C-m
```

### Plugin Customization
- Modify plugin settings in `tmux.conf`
- Add new plugins via TPM
- Customize keybindings for personal workflow