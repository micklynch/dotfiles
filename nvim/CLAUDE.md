# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with Neovim configuration in this repository.

## Neovim Configuration Overview

This Neovim configuration is optimized for modern development workflows with extensive plugin ecosystem and vim-style efficiency.

## Core Architecture

### Plugin Management
- **vim-plug**: Primary plugin manager
- **Installation location**: `~/.local/share/nvim/plugged/`
- **Configuration structure**: All plugins defined between `call plug#begin()` and `call plug#end()`

### Key Configuration Sections
1. **Plugin declarations** (lines 4-56)
2. **Global settings** (lines 58-91)
3. **Plugin configurations** (lines 93-153)
4. **Filetype-specific settings** (lines 155-168)
5. **Custom functions** (lines 170-199)
6. **Custom keybindings** (lines 201-233)

## Essential Development Tasks

### File Management
```vim
" Open files
:Files               " Fuzzy file search
NERDTree             " File explorer (Space+q)
:e filename          " Open specific file

" Navigation
:bnext / :bprevious  " Buffer navigation (Tab/Shift-Tab)
Ctrl-w h/j/k/l       " Window navigation
```

### Code Development
```vim
" Editing
gaip*                " Align text (Space+a)
:TagbarToggle        " Code outline (Space+w)
:Codi                " Interactive scratchpad

" Python specific
<leader>d            " Generate docstring
<leader>x            " Format with yapf
```

### Git Integration
```vim
" Git operations
:Gstatus             " Git status
:Gcommit             " Git commit
:Gdiff               " Git diff
:Gblame              " Git blame
```

### Search and Navigation
```vim
" Search
:Ag pattern          " Search with Ag (if installed)
:Files               " Fuzzy file search
:Buffers             " Buffer search

" Quick navigation
<leader>f            " Find files
<leader><leader>     " Clear search highlight
```

## Plugin-Specific Workflows

### NERDTree File Management
```vim
" Toggle file explorer
<leader>q

" NERDTree operations
o                    # Open file/directory
t                    # Open in new tab
i                    # Open in split
s                    # Open in vsplit
m                    # Show menu
I                    # Toggle hidden files
cd                   # Change CWD to selected node
```

### FZF Integration
```vim
" FZF commands
:Files               " Find files
:GFiles              " Git files
:Buffers             " Open buffers
:Lines               " Lines in loaded buffers
:BLines              " Lines in current buffer

" FZF keybindings in results
Ctrl-t               # Open in new tab
Ctrl-s               # Open in horizontal split
Ctrl-v               # Open in vertical split
```

### Python Development Tools
```vim
" Docstring generation
<leader>d            " Generate docstring for current function

" Code formatting
<leader>x            " Format current buffer with yapf

" Snippets
<leader>j            " Jump to next snippet position
<leader>k            # Jump to previous snippet position
```

### Git Workflow (vim-fugitive)
```vim
" Status and staging
:Gstatus             " Show git status
-                    # Stage/unstage file
cc                   # Commit
ca                   # amend commit
```

### Terminal Integration
```vim
" Open terminal
<leader>s            " Horizontal split with terminal
<leader>vs           " Vertical split with terminal

" Terminal navigation
Ctrl-\ Ctrl-n        # Exit terminal mode
Ctrl-w h/j/k/l       # Navigate from terminal to other windows
```

## Custom Functions Usage

### Theme Switching
```vim
:call ColorDracula() " Apply Dracula theme
:call ColorSeoul256() " Apply Seoul256 theme
:call ColorZazen()    " Apply Zazen theme

" Quick theme switching
<leader>e1           " Dracula
<leader>e2           " Seoul256
<leader>e3           " Zazen
```

### Utility Functions
```vim
:call TrimWhitespace() " Remove trailing whitespace
<leader>t            " Quick access to trim function
```

### Configuration Reloading
```vim
:so ~/.config/nvim/init.vim    " Reload configuration
<leader>r            " Quick reload
```

## Language-Specific Workflows

### Web Development
```vim
" HTML/XML/Jinja (auto-configured)
" 2-space indentation
" Auto-close tags with vim-closetag
" Template-specific snippets
```

### Markdown and Writing
```vim
" Writing mode
<leader>g            " Toggle Goyo (distraction-free)
<leader>l            " Toggle Limelight (focus mode)

" Journaling (if using vim-journal)
:Journal             " Open today's journal entry
```

### General Programming
```vim
" Code alignment
gaip*                " Align around asterisk
ga2<Space>           # Align on 2nd column

" Surround operations
cs"'                 # Change double quotes to single quotes
ds"                  # Delete surrounding quotes
ysiw"                # Add quotes around word
```

## Configuration Management

### Plugin Installation
```bash
# Install plugins
nvim
:PlugInstall

# Update plugins
:PlugUpdate

# Clean unused plugins
:PlugClean
```

### Configuration Location
```bash
# Main configuration
~/.config/nvim/init.vim

# Plugin installation directory
~/.local/share/nvim/plugged/

# Plugin configuration locations
~/.config/nvim/plugged/
```

### Health and Diagnostics
```vim
:checkhealth         " Check Neovim health
:PlugStatus          " Check plugin status
:scriptnames         " List loaded scripts
```

## Advanced Usage Patterns

### Session Management
```vim
" Create session
:mksession session.vim

" Load session
:source session.vim

" Session with vimobsession plugin (if added)
:SaveSession mysession
:OpenSession mysession
```

### Code Navigation
```vim
" Tag navigation (requires ctags)
Ctrl-]               # Jump to tag under cursor
Ctrl-t               # Jump back from tag

" LSP (if added later)
:gd                  # Go to definition
:gr                  # Go to references
```

### Custom Workflows
```vim
" Development workflow setup
" Window 1: Code editing
" Window 2: Terminal (leader+s)
" Window 3: File explorer (leader+q)
" Window 4: Code outline (leader+w)
```

## Integration with Other Tools

### With Tmux
```vim
" Seamless navigation with vim-tmux-navigator
Ctrl-h/j/k/l         # Navigate between vim/tmux panes
```

### With Git
```vim
" Git operations integrated into workflow
:Gdiff               # Diff in vim buffers
:Gread               # Read file from git
:Gwrite              # Write file to git
```

### With System Clipboard
```vim
" System integration
<C-c>                # Copy to system clipboard in visual mode
<C-p>                # Paste from system clipboard
```

## Performance Optimization

### Startup Optimization
- Plugins are loaded on demand where possible
- Lazy loading for heavy operations
- Efficient syntax highlighting with vim-polyglot

### Memory Management
```vim
" Buffer management
:bd                  # Delete buffer
:ls                  # List buffers
:browse buffer       # Browse buffer list
```

### Search Performance
```vim
" Efficient search
/term                # Incremental search
:set ignorecase      # Case insensitive search
:set smartcase       # Smart case sensitivity
```

## Troubleshooting

### Common Issues
```vim
" Plugin not loading
:PlugInstall         # Reinstall plugins
:checkhealth         # Check system dependencies

" Colors not displaying
:set termguicolors   " Enable true color support
:colorscheme dracula " Force color scheme

" Python integration issues
:echo has('python3') " Check Python support
:checkhealth python3 " Check Python health
```

### Performance Issues
```vim
" Slow startup
:scriptnames         # Identify slow-loading scripts
:PlugStatus          # Check plugin status

" Memory usage
:ls                  # Check buffer count
:bd                  # Clean up unused buffers
```

## Extension and Customization

### Adding New Plugins
```vim
" Add to plug section
Plug 'author/plugin-name'

" Install with
:PlugInstall
```

### Custom Keybindings
```vim
" Add to custom mappings section
nnoremap <leader>new_command :YourCommand<CR>
```

### Language-Specific Configuration
```vim
" Add to filetype section
autocmd FileType yourlanguage setlocal yoursetting=value
```

This configuration provides a comprehensive foundation for efficient development workflows while maintaining vim philosophy and extensibility.