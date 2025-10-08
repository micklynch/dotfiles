# Neovim Configuration

This directory contains a comprehensive Neovim configuration optimized for modern development workflows.

## Files

- `init.vim` - Main Neovim configuration file
- `README.md` - This documentation file
- `CLAUDE.md` - Claude Code specific guidance

## Features

### Plugin Management
Uses **vim-plug** as the plugin manager with an extensive plugin ecosystem:

#### Aesthetic & Themes
- **Dracula theme**: Primary color scheme
- **Airline**: Enhanced status line with themes
- **Dev icons**: File type icons in various plugins
- **Multiple themes**: Seoul256, Spring Night, Zazen, and more

#### Development Tools
- **vim-fugitive**: Git integration
- **vim-surround**: Surround/delete/change surrounding characters
- **nerdtree**: File system explorer
- **tagbar**: Code outline/navigation
- **fzf**: Fuzzy file finding and content search
- **ultisnips**: Code snippet engine
- **vim-polyglot**: Language pack for syntax highlighting

#### Editing Enhancements
- **auto-pairs**: Auto-close brackets, quotes, etc.
- **vim-easy-align**: Interactive text alignment
- **supertab**: Tab completion for insert mode
- **indentLine**: Visual indentation guides
- **Colorizer**: Highlight color codes in their actual colors

#### Specialized Tools
- **vim-pydocstring**: Python docstring generator
- **codi.vim**: Interactive code evaluation scratchpad
- **goyo.vim**: Distraction-free writing mode
- **limelight.vim**: Focused editing by dimming surroundings

## Installation

### Prerequisites
1. Install Neovim: https://github.com/neovim/neovim/wiki/Installing-Neovim
2. Install Python 3 with pip (for Python support)

### Setup Steps

1. **Install vim-plug** (plugin manager):
   ```bash
   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   ```

2. **Copy configuration**:
   ```bash
   mkdir -p ~/.config/nvim
   cp init.vim ~/.config/nvim/
   ```

3. **Install plugins**:
   ```bash
   nvim
   :PlugInstall
   ```

4. **Optional - Treesitter setup** (for enhanced syntax highlighting):
   ```bash
   nvim
   :TSInstall
   ```

## Key Features & Usage

### Custom Keybindings (Leader = Space)

#### File Management
- `<Space>q` - Toggle NERDTree file explorer
- `<Space>f` - Fuzzy file search
- `<Space>w` - Toggle Tagbar code outline
- `<Space>t` - Trim trailing whitespace

#### Development Tools
- `<Space>d` - Generate Python docstring
- `<Space>a` - Align text (EasyAlign)
- `<Space>x` - Format Python code with yapf

#### Appearance & Themes
- `<Space>ee` - Browse available colorschemes
- `<Space>e1` - Switch to Dracula theme
- `<Space>e2` - Switch to Seoul256 theme
- `<Space>e3` - Switch to Zazen theme
- `<Space>k` - Toggle colorizer (highlight colors)
- `<Space>g` - Toggle Goyo distraction-free mode

#### Navigation & Sessions
- `<Tab>` - Next buffer
- `<Shift-Tab>` - Previous buffer
- `<Space><Space>` - Clear search highlighting

#### Terminal Integration
- `<Space>s` - Split horizontal with terminal
- `<Space>vs` - Split vertical with terminal

### Plugin-Specific Features

#### NERDTree (File Explorer)
- Shows hidden files by default
- Custom arrow indicators for expandable/collapsible directories
- Integrated with Git for status indicators

#### FZF Integration
- `<Ctrl-t>` - Open in new tab
- `<Ctrl-s>` - Open in horizontal split
- `<Ctrl-v>` - Open in vertical split
- Custom color scheme matching Dracula theme

#### Python Development
- **yapf integration**: Format Python code with `<Space>x`
- **pydocstring**: Generate docstrings with `<Space>d`
- **UltiSnips**: Tab-triggered code snippets
- **Auto-completion**: Language-agnostic completion via SuperTab

#### Git Integration
- **vim-fugitive**: Full Git commands within Neovim
- **Git status**: View staged/unstaged changes
- **Git blame**: Track line history
- **Git diff**: Enhanced diff viewing

### Configuration Details

#### Editor Settings
- **Indentation**: 4 spaces, expand tabs
- **Line numbers**: Absolute numbers (no relative)
- **Search**: Case-insensitive, incremental search
- **Encoding**: UTF-8
- **Mouse support**: Enabled for terminal environments

#### Theme Configuration
- **Primary theme**: Dracula (dark theme)
- **Transparent background**: For compton/i3 compatibility
- **Enhanced colors**: Custom popup menu and comment highlighting
- **Airline**: Custom time display in status line

#### Terminal Integration
- **Neovim terminal**: Enhanced navigation and mode switching
- **Escape sequences**: Custom mappings for terminal mode
- **Auto-insert**: Automatically enter insert mode in terminal buffers

## Language Support

### Web Development
- **HTML/XML**: 2-space indentation
- **CSS**: 2-space indentation
- **Jinja/Django**: Template-specific snippets and indentation

### Markdown & Writing
- **2-space indentation** for consistency
- **Goyo + Limelight**: Distraction-free writing environment
- **vim-journal**: Journaling support

### Python
- **yapf formatting**: Code formatting integration
- **pydocstring**: Docstring generation
- **Syntax highlighting**: Enhanced via vim-polyglot

## Custom Functions

### Color Themes
- `ColorDracula()` - Apply Dracula theme with airline
- `ColorSeoul256()` - Apply Seoul256 theme (supports light/dark)
- `ColorZazen()` - Apply minimalist black & white theme

### Utility Functions
- `TrimWhitespace()` - Remove trailing whitespace from buffer
- Custom clipboard operations for system integration

## Performance Optimizations

- **Lazy loading** for heavy plugins where applicable
- **Efficient syntax highlighting** with vim-polyglot
- **Optimized search** with smart case sensitivity
- **Minimal startup impact** through careful plugin selection

## Troubleshooting

### Common Issues
- **Plugins not loading**: Run `:PlugInstall` and `:PlugUpdate`
- **Python support missing**: Install `pynvim` package: `pip install pynvim`
- **Colors not displaying**: Ensure terminal supports true color
- **Clipboard not working**: Check system clipboard integration

### Health Checks
Run `:checkhealth` in Neovim to diagnose configuration issues.

### Plugin Issues
- **Update plugins**: `:PlugUpdate`
- **Clean unused plugins**: `:PlugClean`
- **Review plugin config**: Check `init.vim` plugin configurations

## Extending the Configuration

### Adding New Plugins
1. Add `Plug 'author/plugin'` between `call plug#begin()` and `call plug#end()`
2. Run `:PlugInstall`
3. Add any plugin-specific configuration

### Custom Keybindings
Add custom mappings to the `" Custom Mappings` section using the `<leader>` key convention.

### Language-Specific Settings
Use `autocmd FileType` commands for language-specific configurations (examples included for HTML, CSS, Markdown, etc.).