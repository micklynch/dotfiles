# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with Midnight Commander configuration in this repository.

## Midnight Commander Configuration Overview

This Midnight Commander (MC) configuration is optimized for terminal-based file management with enhanced editing capabilities and efficient workflow integration.

## Key Configuration Features

### Interface Optimization
- **Dark theme**: Reduced eye strain for extended use
- **Mouse support**: Click navigation and drag operations
- **Auto-save setup**: Preserves panel states and settings
- **Show hidden files**: Complete visibility of file system

### Editor Integration
- **Internal editor**: Full-featured text editor with syntax highlighting
- **Auto-indentation**: Smart indentation for code files
- **Syntax highlighting**: Enhanced code readability
- **Tab handling**: Configurable tab width and behavior

### File Operations
- **Verbose output**: Detailed progress information
- **Confirmation dialogs**: Safety prompts for destructive operations
- **Persistent attributes**: Preserves file permissions and metadata
- **Backup creation**: Automatic backup files with `~` extension

## Common Development Tasks

### File Navigation
```bash
# Start MC
mc

# Navigation basics
Tab           # Switch between panels
Arrow keys    # Navigate within panels
Enter         # Enter directory or open file
Alt + Enter   # View file information
```

### File Operations
```bash
# File management
F5            # Copy files/directories
F6            # Move/rename files/directories
F7            # Create new directory
F8            # Delete files (with confirmation)
Insert        # Select/deselect files

# Quick operations
Ctrl + x s    # Create symbolic link
Ctrl + x l    # Create hard link
Ctrl + x t    # Tag selected files
```

### Editor Usage
```bash
# Edit files
F4            # Edit file in internal editor
F3            # View file in internal viewer

# In editor
F2            # Save file
F10           # Exit editor
Ctrl + k      # Delete line
Ctrl + u      # Undelete line
```

### Directory Operations
```bash
# Directory navigation
Alt + o       # Browse directory in other panel
Alt + i       # Sync directories
Alt + t       # Toggle directory tree view
Ctrl + r      # Reread directory

# Directory bookmarks
Ctrl + \      # Go to root directory
Alt + .       # Go to current working directory
```

## Development Workflow Integration

### With Neovim Configuration
```bash
# Open file in nvim from MC
F4            # Internal editor (configured)
# or use external editor: select file, then:
F9 -> Command -> Edit extension file

# Quick edit workflow
# Navigate in MC -> F4 to edit -> F10 save/exit -> continue navigation
```

### Git Repository Management
```bash
# Use Panelize commands for Git operations
Ctrl + \      # Panelize menu
Select "Modified git files"    # Show only modified files

# Git workflow in MC
# Navigate repository -> Panelize modified files -> Edit -> Git operations
```

### Project Structure Navigation
```bash
# Efficient project browsing
# Left panel: Source code
# Right panel: Tests or documentation

# Quick directory switching
Alt + <       # Previous directory
Alt + >       # Next directory
```

## Configuration Management

### Applying This Configuration
```bash
# Create config directory
mkdir -p ~/.config/mc

# Copy configuration
cp midnight-commander/ini ~/.config/mc/ini

# Alternative legacy location
mkdir -p ~/.mc
cp midnight-commander/ini ~/.mc/ini
```

### Verification
```bash
# Start MC and check settings
mc

# Verify key settings
F9 -> Options -> Configuration
# Check: Auto save setup, Confirm delete, etc.
```

## Advanced Usage Patterns

### File Search and Management
```bash
# Quick file find
Ctrl + s      # Quick search in current panel
Alt + s       # Continue search

# Advanced find
Ctrl + \      # Panelize -> Find file
# Use built-in find commands or custom patterns
```

### Archive Operations
```bash
# Navigate archives as directories
# Enter .tar, .zip, .gz files directly
# Copy files in/out of archives

# Create archives
Select files -> F9 -> File -> Pack
```

### Network Operations
```bash
# FTP/SFTP connections
cd ftp://user@server/path
# Navigate remote files like local directories

# File transfers between local/remote
# Left panel: local, Right panel: remote
# Standard copy operations (F5) work across connections
```

### Batch Operations
```bash
# Multiple file selection
Insert        # Toggle selection
+             # Select by pattern
-             # Unselect by pattern
*             # Invert selection

# Batch operations on selected files
F5/F6/F8      # Copy/move/delete all selected
```

## Integration with Terminal Workflow

### With Tmux Sessions
```bash
# Ideal tmux layout for MC workflow
# Window 1: MC for file management
# Window 2: Terminal for commands
# Window 3: Editor (nvim) for coding

# Quick switching between MC and terminal
Ctrl-Space c    # New tmux window
Alt + Tab       # Switch back to MC
```

### Command Execution
```bash
# Execute shell commands from MC
Ctrl + o       # Shell out temporarily
!command       # Execute command and return
Enter          # Execute command from command line

# Command history
Alt + h        # Command history
```

### File Preview
```bash
# Quick file preview
Right arrow    # Preview file in passive panel
Ctrl + x q     # Quick view mode
Alt + p        # Toggle info panel
```

## Customization and Extension

### Adding Custom Panelize Commands
Edit the `ini` file to add custom commands to the `[Panelize]` section:
```ini
# Custom panelize commands
Find Python files = find . -name "*.py" -print
Large files = find . -size +10M -print
Recent files = find . -mtime -7 -print
```

### External Editor Configuration
```bash
# Configure external editor in MC
F9 -> Options -> Configuration -> Use internal edit
# Disable to use external editor like nvim

# Set external editor
F9 -> Command -> Edit extension file
# Add your preferred editor associations
```

### Custom File Types
```bash
# Configure file type associations
F9 -> Command -> Edit menu file
# Add custom file type actions and viewers
```

## Performance Optimization

### Large Directory Handling
```bash
# For large directories, consider:
F9 -> Options -> Configuration -> Fast reload
# Enable for better performance with many files
```

### Memory Usage
```bash
# Optimize for system resources
# Current config balances features and performance
# Adjust VFS timeout settings for network operations
```

## Troubleshooting

### Common Issues
- **Mouse not working**: Check terminal mouse support
- **Colors incorrect**: Verify terminal color support (256-color)
- **Editor not saving**: Check file permissions and disk space

### Configuration Conflicts
If settings don't apply:
1. Verify `~/.config/mc/ini` exists
2. Check file permissions
3. Restart MC after configuration changes

### Performance Issues
- **Slow startup**: Disable auto-save setup or reduce panelize commands
- **Large directories**: Enable fast reload option
- **Network slowness**: Adjust VFS timeout settings

## Best Practices

### File Organization
- Use MC for bulk file operations
- Leverage panelize for focused work
- Use directory bookmarks for frequent locations

### Safety
- Keep confirmations enabled for destructive operations
- Use backup files for important changes
- Verify file operations with preview before execution

### Workflow Integration
- Combine MC with tmux for efficient terminal workflow
- Use MC for file management, nvim for editing
- Integrate with Git operations via panelize commands