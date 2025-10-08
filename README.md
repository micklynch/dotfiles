# Mick's Dotfiles

A comprehensive collection of configuration files for terminal-based development tools, optimized for modern workflows and vim-style efficiency.

## Repository Structure

This repository is organized into application-specific directories, each containing configuration files and comprehensive documentation:

```
dotfiles/
├── git/                     # Git configuration
│   ├── gitconfig           # Main git configuration file
│   ├── README.md           # Git setup and usage guide
│   └── CLAUDE.md           # Claude Code guidance for Git
├── nvim/                    # Neovim configuration
│   ├── init.vim            # Main Neovim configuration
│   ├── README.md           # Complete Neovim setup guide
│   └── CLAUDE.md           # Claude Code guidance for Neovim
├── tmux/                    # Tmux configuration
│   ├── tmux.conf           # Main Tmux configuration
│   ├── README.md           # Tmux setup and usage guide
│   └── CLAUDE.md           # Claude Code guidance for Tmux
├── midnight-commander/      # Midnight Commander configuration
│   ├── ini                 # MC configuration file
│   ├── README.md           # MC setup and usage guide
│   └── CLAUDE.md           # Claude Code guidance for MC
├── README.md               # This file
└── CLAUDE.md               # Main Claude Code guidance
```

## Applications Configured

### 🖥️ Neovim
Highly customized Neovim setup with extensive plugin ecosystem:
- **Plugin Manager**: vim-plug with 30+ curated plugins
- **Theme**: Dracula dark theme with multiple alternatives
- **Features**: Git integration, fuzzy finding, code completion, Python development tools
- **Documentation**: Complete setup guide and keybinding reference

### 🪟 Tmux
Terminal multiplexer optimized for development workflows:
- **Prefix Key**: Ctrl-Space (ergonomic alternative to Ctrl-b)
- **Plugins**: TPM-managed with vim-tmux-navigator, catppuccin theme
- **Features**: Mouse support, vim-style navigation, system clipboard integration
- **Documentation**: Installation guide and comprehensive key reference

### 📦 Git
Modern Git configuration optimized for clean history:
- **Workflow**: Rebase-based with auto-stash protection
- **Features**: Enhanced diff display, nvimdiff integration, custom aliases
- **Settings**: Main branch as default, automatic pruning, colored diffs
- **Documentation**: Configuration details and usage patterns

### 📁 Midnight Commander
Powerful terminal file manager configuration:
- **Interface**: Dark theme with mouse support and enhanced navigation
- **Features**: Internal editor with syntax highlighting, archive handling, network operations
- **Integration**: Seamless workflow with other terminal tools
- **Documentation**: Complete usage guide and workflow integration

## Quick Installation

### Prerequisites
- Unix-like system (Linux, macOS, BSD)
- Modern terminal with 256-color support
- Git, Neovim, Tmux, Midnight Commander installed

### Automated Setup
```bash
# Clone repository
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run setup script (create one if needed)
# ./setup.sh  # Optional: Create a setup script for automation
```

### Manual Installation

#### Neovim
```bash
# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Copy configuration
mkdir -p ~/.config/nvim
cp nvim/init.vim ~/.config/nvim/

# Install plugins
nvim +PlugInstall +qall
```

#### Tmux
```bash
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Copy configuration
mkdir -p ~/.config/tmux
cp tmux/tmux.conf ~/.config/tmux/tmux.conf

# Source and install plugins
tmux source ~/.config/tmux/tmux.conf
tmux new -s temp \; send-keys 'prefix I' C-m \; detach-client
```

#### Git
```bash
# Copy configuration
cp git/gitconfig ~/.gitconfig

# Or merge with existing configuration
cat git/gitconfig >> ~/.gitconfig
```

#### Midnight Commander
```bash
# Create config directory
mkdir -p ~/.config/mc

# Copy configuration
cp midnight-commander/ini ~/.config/mc/ini
```

## Key Features

### Unified Development Philosophy
- **Vim-style navigation** across all tools
- **Keyboard-driven workflow** with mouse support where beneficial
- **Dark theme consistency** across applications
- **Terminal optimization** for modern development

### Integration Highlights
- **Seamless navigation** between Vim and Tmux panes
- **Git integration** in Neovim and enhanced Git configuration
- **Consistent keybindings** and muscle memory across tools
- **System clipboard** integration where possible

### Performance Optimizations
- **Minimal startup impact** through careful plugin selection
- **Efficient search** and navigation capabilities
- **Resource-conscious** configuration settings
- **Lazy loading** for heavy operations where applicable

## Documentation Structure

Each application directory contains two comprehensive documentation files:

### README.md Files
- **Installation instructions** with step-by-step guides
- **Feature descriptions** and configuration details
- **Keybinding references** and usage examples
- **Troubleshooting guides** for common issues

### CLAUDE.md Files
- **Claude Code specific guidance** for AI assistance
- **Development workflow recommendations**
- **Integration patterns** between tools
- **Best practices** for efficient development

## Development Workflow

### Typical Session Setup
```bash
# Start tmux session
tmux new -s development

# Window 1: Neovim for coding
nvim project/

# Window 2: Terminal for commands
# (Ctrl-Space c to create new window)

# Window 3: File management (optional)
mc  # Midnight Commander for file operations
```

### Daily Workflow
1. **Start tmux** with development session
2. **Open Neovim** for primary development work
3. **Use integrated tools** (Git, file management, terminals)
4. **Leverage custom keybindings** for efficiency
5. **Navigate seamlessly** between tools and panes

## Customization and Extension

### Adding Personal Configurations
- Modify files in respective application directories
- Add custom keybindings following existing patterns
- Extend functionality with additional plugins or settings

### Version Control
- Track personal customizations in separate branches
- Use Git to manage configuration evolution
- Maintain documentation for any custom additions

### Sharing and Backup
- Repository serves as backup of configuration files
- Easy setup on new machines or systems
- Share specific configurations with team members

## Troubleshooting

### Common Issues
- **Permission errors**: Ensure proper file permissions for config files
- **Plugin installation**: Verify network connectivity and plugin manager setup
- **Color display**: Check terminal color support (256-color minimum)
- **Keybinding conflicts**: Verify prefix keys and terminal configuration

### Support Resources
- Application-specific documentation in respective README.md files
- Claude Code guidance in CLAUDE.md files
- Official documentation for each application
- Community forums and issue trackers

## Contributing

This is a personal configuration repository but contributions and suggestions are welcome:

1. **Configuration improvements** and optimizations
2. **Documentation enhancements** and corrections
3. **Integration patterns** between tools
4. **Performance optimizations** and best practices

## License

This repository contains personal configuration files. Feel free to use, modify, and adapt them for your own needs.

## System Compatibility

### Supported Systems
- **Linux**: All modern distributions
- **macOS**: Recent versions with Homebrew packages
- **BSD**: Compatible systems with package managers

### Requirements
- **Terminal**: 256-color support recommended
- **Neovim**: 0.4+ (current stable)
- **Tmux**: 2.0+ with TPM support
- **Git**: 2.0+ for all features
- **Midnight Commander**: 4.8+ for full compatibility

---

*This dotfiles collection represents years of terminal-based development experience, continuously refined for efficiency and productivity.*