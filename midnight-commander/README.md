# Midnight Commander Configuration

This directory contains configuration files for Midnight Commander (MC), a powerful visual file manager for the terminal.

## Files

- `ini` - Main Midnight Commander configuration file

## Features

### General Settings
- **Auto-save setup**: Automatically saves panel settings and configuration
- **Internal editor/viewer**: Uses MC's built-in editor and file viewer
- **Mouse support**: Full mouse support for navigation and selection
- **Confirmation dialogs**: Prompts for destructive operations (delete, overwrite)
- **Shell patterns**: Enhanced pattern matching in file operations

### Editor Configuration
- **Syntax highlighting**: Enabled for supported file types
- **Auto indent**: Smart indentation for code files
- **Tab spacing**: 8 spaces (configurable)
- **Line wrapping**: Disabled by default
- **Backup files**: Creates backup files with `~` extension

### File Operations
- **Safe operations**: Disabled for speed (be cautious with destructive operations)
- **Verbose output**: Detailed file operation progress
- **Persistent attributes**: Preserves file permissions and metadata during copy/move
- **Compute totals**: Shows total size and file count for operations

### Interface Customization
- **Dark theme**: Uses the built-in dark skin
- **Show hidden files**: Displays dot files and hidden directories
- **Show backups**: Includes backup files in listings
- **Quick search mode**: Enhanced file searching with incremental search

### Navigation Features
- **Panelize commands**: Predefined commands for common file discovery tasks:
  - Find `*.orig` files after patching
  - Find SUID/SGID executables
  - Find `*.rej` files after patching
  - Show modified Git files

## Installation

1. Copy the configuration file to the MC config directory:
   ```bash
   mkdir -p ~/.config/mc
   cp ini ~/.config/mc/ini
   ```

2. Alternatively, copy to the legacy location:
   ```bash
   cp ini ~/.mc/ini
   ```

## Key Features Overview

### File Management
- **Dual-panel interface**: Traditional commander-style layout
- **Drag and drop**: Mouse support for file operations
- **Batch operations**: Multiple file selection and operations
- **Preview panel**: Quick file preview in side panel

### Editing Capabilities
- **Built-in editor**: Full-featured text editor with syntax highlighting
- **External editor support**: Can launch external editors (Vim, Emacs, etc.)
- **Hex editing**: Built-in hex editor for binary files
- **Macro recording**: Record and playback editing macros

### File Operations
- **Copy/Move/Rename**: Full file system operations
- **Delete with confirmation**: Safety prompts for destructive operations
- **Archive handling**: Built-in support for tar, zip, gzip, and other archives
- **Network protocols**: FTP, SFTP, and other network file systems

### Navigation
- **CD to current directory**: Quick directory changes
- **Directory hotlist**: Bookmark frequently accessed directories
- **Find file**: Powerful file search with pattern matching
- **Virtual file system**: Browsing inside archives and remote file systems

## Configuration Details

### Editor Settings
- **Tab width**: 8 characters
- **Word wrap**: 72 characters
- **Auto indent**: Enabled
- **Syntax highlighting**: Enabled
- **Line numbers**: Disabled (can be enabled via F9 menu)

### File Display
- **Show dot files**: Hidden files visible
- **Show backups**: Backup files included
- **File type mode**: File type detection and icons
- **Permission mode**: File permissions visible

### Performance Settings
- **Fast reload**: Disabled for accuracy
- **Virtual file system timeout**: 60 seconds
- **Operation timeout**: 30 seconds for FTP operations

## Usage Tips

### Navigation
- `Tab` - Switch between panels
- `Insert` - Select/deselect files
- `F3` - View file
- `F4` - Edit file
- `F5` - Copy
- `F6` - Move/rename
- `F7` - Create directory
- `F8` - Delete
- `F9` - Pull down menu
- `F10` - Exit

### Advanced Features
- `Ctrl-x s` - Create symbolic link
- `Ctrl-x l` - Create hard link
- `Ctrl-x p` - Put files from other panel
- `Ctrl-x t` - Tag files
- `Ctrl-x q` - Quick view mode
- `Ctrl-x c` - Compare directories

### File Operations
- `Alt-o` - Browse directory in other panel
- `Alt-i` - Sync directories
- `Alt-Enter` - View file information
- `Alt-Tab` - Switch between panels (alternative to Tab)

## Compatibility

This configuration is compatible with:
- Midnight Commander 4.8+
- Any terminal with basic ANSI support
- Unix-like systems (Linux, macOS, BSD)

## Customization

The configuration file can be further customized by:
- Modifying the `[Layout]` section for interface preferences
- Adjusting editor settings in the file operation sections
- Adding custom commands to the `[Panelize]` section
- Changing the color scheme via the `skin` parameter