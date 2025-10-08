# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive dotfiles repository containing configuration files for terminal-based development tools. The repository is organized into application-specific directories, each with detailed documentation for both human users and AI assistance.

### Architecture Philosophy

The configuration emphasizes:
- **Terminal-first workflow** optimized for keyboard-driven development
- **Vim-style consistency** across all applications for muscle memory
- **Modern development practices** with Git integration and efficient workflows
- **Performance optimization** through careful plugin selection and configuration
- **Cross-tool integration** for seamless development experience

## Application Structure

Each application directory contains:
- **Configuration files**: Main setup files for the application
- **README.md**: Comprehensive documentation for human users
- **CLAUDE.md**: AI-specific guidance for development and configuration tasks

### Configured Applications

#### Neovim (`nvim/`)
- **Purpose**: Primary code editor with extensive plugin ecosystem
- **Key Features**: vim-plug manager, Dracula theme, Git integration, fuzzy finding
- **Integration**: Seamless navigation with Tmux, Git workflow integration
- **Claude Guidance**: See `nvim/CLAUDE.md` for plugin management and configuration tasks

#### Tmux (`tmux/`)
- **Purpose**: Terminal multiplexer for session and window management
- **Key Features**: Ctrl-Space prefix, vim-tmux-navigator, Catppuccin theme
- **Integration**: Vim-style navigation, system clipboard, Neovim pane navigation
- **Claude Guidance**: See `tmux/CLAUDE.md` for session management and plugin operations

#### Git (`git/`)
- **Purpose**: Version control with modern workflow configuration
- **Key Features**: Rebase-based workflow, nvimdiff integration, enhanced diff display
- **Integration**: Neovim Git tools, clean history management
- **Claude Guidance**: See `git/CLAUDE.md` for workflow patterns and configuration management

#### Midnight Commander (`midnight-commander/`)
- **Purpose**: Terminal file manager with integrated editor
- **Key Features**: Dark theme, mouse support, archive handling, network operations
- **Integration**: Works alongside Neovim and Tmux for file management workflows
- **Claude Guidance**: See `midnight-commander/CLAUDE.md` for file operations and integration patterns

## Development Workflow Patterns

### Typical Development Session
```bash
# Start Tmux session
tmux new -s development

# Window 1: Primary coding (Neovim)
nvim project/

# Window 2: Terminal operations
# Ctrl-Space c for new window

# Window 3: File management (optional)
mc
```

### Integrated Operations
- **Navigation**: Use vim-tmux-navigator for seamless Neovim/Tmux pane movement
- **Git operations**: Use Git configuration with Neovim's vim-fugitive integration
- **File management**: Use Midnight Commander for bulk operations, Neovim for editing
- **Search**: Use Neovim's FZF integration for file finding and content search

### Configuration Interdependencies
- **Neovim ↔ Tmux**: vim-tmux-navigator enables cross-application navigation
- **Neovim ↔ Git**: vim-fugitive integrates Git operations into editing workflow
- **Git ↔ System**: Git configuration uses Neovim for diff/merge operations
- **All applications**: Consistent color schemes and keyboard patterns

## Common Development Tasks

### Repository Setup
When working with this dotfiles repository:

1. **Configuration Management**: Always modify files in application-specific directories
2. **Documentation Updates**: Update both README.md and CLAUDE.md files when making changes
3. **Testing**: Test configuration changes in isolated environments before deployment
4. **Version Control**: Use Git to track configuration evolution and rollback changes

### Plugin and Configuration Management

#### Neovim
```bash
# Plugin operations
nvim +PlugInstall +qall    # Install plugins
nvim +PlugUpdate +qall     # Update plugins
nvim +PlugClean +qall      # Clean unused plugins

# Configuration reloading
:source ~/.config/nvim/init.vim
# or use leader+r mapping
```

#### Tmux
```bash
# Plugin operations via TPM
tmux source ~/.config/tmux/tmux.conf
# Then use prefix+I to install plugins
```

#### Git
```bash
# Apply configuration
cp git/gitconfig ~/.gitconfig

# Test configuration
git config --list | grep -E "(pull|rebase|diff)"
git s  # Test custom alias
```

#### Midnight Commander
```bash
# Apply configuration
mkdir -p ~/.config/mc
cp midnight-commander/ini ~/.config/mc/ini
```

### Workflow Integration Tasks

#### Code Development
1. Use Neovim as primary editor with extensive plugin support
2. Leverage Tmux for terminal management and multi-tasking
3. Use Git configuration for clean version control workflow
4. Employ Midnight Commander for complex file operations

#### Configuration Maintenance
1. Keep documentation synchronized with configuration changes
2. Test configuration compatibility after updates
3. Maintain consistent themes and keybindings across applications
4. Document custom workflows and integration patterns

## Installation and Deployment

### New System Setup
For setting up on a new system:

1. **Clone repository** to `~/.dotfiles`
2. **Install prerequisites** (Neovim, Tmux, Git, Midnight Commander)
3. **Run application-specific setup** from each README.md
4. **Test integration** between tools
5. **Customize** for personal preferences

### Configuration Updates
When updating configurations:

1. **Backup existing configurations** before applying changes
2. **Apply changes incrementally** to identify issues quickly
3. **Test each application** individually before integration testing
4. **Update documentation** to reflect configuration changes

### Troubleshooting Approach

#### Application-Specific Issues
- Consult application-specific README.md for setup issues
- Check application-specific CLAUDE.md for development guidance
- Verify configuration file syntax and locations
- Test with minimal configuration to isolate problems

#### Integration Issues
- Check for conflicting keybindings between applications
- Verify terminal capabilities (color support, mouse handling)
- Test plugin compatibility and versions
- Ensure configuration files are properly sourced

#### Performance Issues
- Review plugin load order and dependencies
- Check for resource-intensive configurations
- Optimize startup time through selective plugin loading
- Monitor memory usage with multiple applications running

## Best Practices for Claude Code

### Configuration Tasks
- **Always read existing configuration files** before making modifications
- **Understand interdependencies** between applications when making changes
- **Test changes in isolation** before integration
- **Maintain documentation** consistency across README.md and CLAUDE.md files

### Development Assistance
- **Leverage application-specific CLAUDE.md files** for detailed guidance
- **Follow established patterns** for keybindings and configuration structure
- **Consider workflow implications** when adding new features
- **Maintain performance** awareness when suggesting plugin additions

### Documentation Maintenance
- **Update both README.md and CLAUDE.md** when making configuration changes
- **Keep installation instructions** current and tested
- **Document integration patterns** and workflows
- **Provide troubleshooting guidance** for common issues

## Repository Organization Principles

### Separation of Concerns
- Each application has its own directory with complete configuration
- Documentation is duplicated appropriately (README.md for users, CLAUDE.md for AI)
- Configuration files are self-contained and independently deployable

### Consistency Standards
- **Color themes**: Dark themes across all applications where possible
- **Keybinding patterns**: Vim-style navigation consistency
- **Configuration structure**: Similar organization across application directories
- **Documentation quality**: Comprehensive guides for both human and AI users

### Integration Design
- **Cross-application workflows** are documented and tested
- **Configuration dependencies** are clearly identified
- **Performance considerations** are built into configuration choices
- **Extensibility** is maintained through modular plugin organization

---

This repository represents a cohesive development environment optimized for terminal-based workflows while maintaining flexibility for personal customization and evolution.