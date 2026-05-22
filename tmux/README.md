# Tmux Configuration

This directory contains a comprehensive Tmux configuration optimized for terminal-based development workflows.

## Files

- `tmux.conf` - Main Tmux configuration file

## Features

### Custom Keybindings
- **Prefix key**: `Ctrl-Space` (instead of default `Ctrl-b`)
- **Vim-style navigation**: Use `h/j/k/l` to navigate between panes
- **Window navigation**: `Shift + Left/Right` or `Alt + H/L` to switch windows
- **Pane creation**: `|` for vertical split, `-` for horizontal split

### Plugin Management
Uses TPM (Tmux Plugin Manager) with the following plugins:
- `tmux-sensible` - Sensible default Tmux settings
- `vim-tmux-navigator` - Seamless navigation between Vim and Tmux panes
- `catppuccin-tmux` - Modern Catppuccin color scheme (mocha flavor)
- `tmux-yank` - Enhanced clipboard support for system integration
- `tmux-resurrect` - Save and restore tmux sessions
- `tmux-continuum` - Automatic continuous saving of tmux sessions

### Visual Features
- **Mouse support**: Click to select panes, drag to resize
- **True color**: Enhanced color support for modern terminals
- **Vi mode**: Vi-style keybindings in copy mode
- **Base indexing**: Windows and panes start at 1 (more intuitive)

### Session Management
- **Automatic renumbering**: Windows renumber automatically when closed
- **Current path preservation**: New panes/splits inherit current directory

### Session Persistence
- **tmux-resurrect**: Manually save and restore complete tmux sessions (panes, windows, layouts)
- **tmux-continuum**: Automatically restore the last saved session when tmux starts
- **Pane contents**: Resurrect captures and restores pane contents

## Installation

1. Install TPM (Tmux Plugin Manager):
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

2. Copy the configuration file:
   ```bash
   cp tmux.conf ~/.config/tmux/tmux.conf
   ```

3. Source the configuration:
   ```bash
   tmux source ~/.config/tmux/tmux.conf
   ```

4. Install plugins:
   - Start Tmux: `tmux`
   - Install plugins: `Ctrl-Space I`

## Optional Shell Integration

To automatically attach to existing sessions or restore the last saved session when starting tmux, add the following to your shell configuration (e.g., `~/.zshrc` or `~/.bashrc`):

```bash
alias ta='tmux attach || tmux'

# Tmux wrapper: attach to existing session or restore last saved session
t() {
  if tmux list-sessions 2>/dev/null | grep -q .; then
    # Sessions exist, attach to the most recently used one
    tmux attach-session
  else
    # No sessions exist, start tmux and restore last saved session
    tmux new-session -d && tmux run-shell ~/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh && tmux attach-session
  fi
}

# Optional: alias 'tmux' to the wrapper function
alias tmux='t'
```

This integration works with the `tmux-resurrect` and `tmux-continuum` plugins to provide a seamless session restoration experience.

## Key Reference

### Session Management
- `tmux` - Start new session
- `Ctrl-Space d` - Detach from session
- `Ctrl-Space s` - Show all sessions

### Window Management
- `Ctrl-Space c` - Create new window
- `Ctrl-Space ,` - Rename current window
- `Shift + Left/Right` - Switch between windows
- `Alt + H/L` - Alternative window switching

### Pane Management
- `Ctrl-Space |` - Split vertically
- `Ctrl-Space -` - Split horizontally
- `Ctrl-Space h/j/k/l` - Navigate between panes
- `Alt + Arrow keys` - Navigate without prefix
- `Ctrl-Space z` - Zoom/unzoom current pane

### Copy Mode (Vi-style)
- `Ctrl-Space [` - Enter copy mode
- `v` - Start selection
- `y` - Copy selection
- `Ctrl-v` - Rectangle selection

### Plugin Commands
- `Ctrl-Space I` - Install plugins
- `Ctrl-Space U` - Update plugins
- `Ctrl-Space alt u` - Uninstall plugins not in the list

## Configuration Notes

### Terminal Compatibility
- Requires `xterm-256color` or better terminal support
- True color support enabled via `set-option -sa terminal-overrides`

### Navigation Integration
The `vim-tmux-navigator` plugin enables seamless navigation:
- Use `Ctrl-h/j/k/l` to navigate between Vim splits and Tmux panes
- Works without the Tmux prefix key when inside Vim

### Theme Configuration
- Uses Catppuccin Mocha theme for modern, consistent appearance
- Color scheme optimized for dark terminal backgrounds

## Troubleshooting

- If plugins don't load: Ensure TPM is installed at `~/.tmux/plugins/tpm`
- If colors appear incorrect: Check terminal color support (256-color minimum)
- If prefix key doesn't work: Verify `tmux.conf` is properly sourced