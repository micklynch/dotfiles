# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with Git configuration in this repository.

## Git Configuration Overview

This Git configuration is optimized for modern development workflows with a focus on clean history and efficient operations.

## Key Configuration Features

### Rebase-Based Workflow
- **Automatic rebase on pull**: Maintains linear history
- **Auto-stash during rebase**: Safeguards local changes
- **Main as default branch**: Modern Git naming convention

### Enhanced Diff Display
- **Zebra color mode**: Highlights moved code blocks with alternating colors
- **nvimdiff integration**: Uses Neovim for merge and diff operations
- **Auto-pruning**: Removes stale remote-tracking branches

### Custom Aliases
- `git s`: Quick diff between current commit and previous commit (`HEAD^` vs `HEAD`)

## Common Development Tasks

### Repository Setup
When working with repositories that use this configuration:

```bash
# Clone with this config active
git clone <repository-url>
cd <repository>

# The configuration is automatically applied via ~/.gitconfig
```

### Daily Workflow
```bash
# Pull with automatic rebase
git pull

# Check changes with enhanced diff
git s  # custom alias for HEAD^ vs HEAD

# Merge conflicts open in nvimdiff
git merge <branch>
# or
git rebase <branch>
```

### Branch Management
```bash
# Create new branch (defaults to main)
git checkout -b feature-branch

# Switch to main branch
git checkout main

# Compare branches with colored diff
git diff main...feature-branch
```

## File Operations

### Viewing Changes
```bash
# Enhanced diff with zebra coloring
git diff

# Use nvimdiff for detailed comparison
git difftool

# Quick previous commit comparison
git s
```

### Merge Operations
```bash
# Merge opens nvimdiff for conflicts
git merge feature-branch

# Rebase with auto-stash protection
git rebase main
```

## Configuration Management

### Applying This Configuration
```bash
# Copy to user config
cp git/gitconfig ~/.gitconfig

# Or merge with existing config
cat git/gitconfig >> ~/.gitconfig
```

### Verification
```bash
# Check current configuration
git config --list | grep -E "(pull|rebase|diff|branch)"

# Test custom alias
git s  # should show diff with previous commit
```

## Development Patterns

### Feature Development Workflow
1. Create feature branch from main
2. Work locally with regular commits
3. Pull latest changes (auto-rebases)
4. Resolve conflicts in nvimdiff if needed
5. Merge to main or create pull request

### Commit History Management
- Linear history preferred (rebase workflow)
- Auto-stash protects work during rebase operations
- Enhanced diff viewing for code review

### Integration with Other Tools
- **Neovim**: Seamlessly integrated for merge/diff operations
- **Terminal**: Enhanced color output for better readability
- **IDEs**: Compatible with IDE Git integrations

## Troubleshooting

### Common Issues
- **Merge conflicts**: nvimdiff opens automatically - use standard vim diff commands
- **Rebase conflicts**: Auto-stash should prevent most issues
- **Color not showing**: Ensure terminal supports ANSI colors

### Configuration Conflicts
If this config conflicts with existing settings:
1. Backup current `~/.gitconfig`
2. Manually merge desired settings
3. Test with a sample repository

### Performance Considerations
- Auto-pruning keeps remote tracking clean
- Rebase workflow maintains cleaner history
- nvimdiff provides efficient conflict resolution

## Advanced Usage

### Customizing the Configuration
- Modify `git/gitconfig` directly for personal preferences
- Add more aliases to the `[alias]` section
- Adjust merge/diff tool preferences

### Integration with Development Environment
- Works seamlessly with the Neovim configuration in this repository
- Compatible with modern IDE Git integrations
- Supports various Git workflows (GitFlow, GitHub Flow, etc.)

### Automation and Scripts
The configuration can be referenced in automation scripts:
```bash
#!/bin/bash
# Use the enhanced diff for automated reviews
git s --stat  # custom alias for quick overview
```