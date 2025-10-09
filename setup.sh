#!/usr/bin/env bash
set -euo pipefail

# Cross-platform setup script for Mick's Dotfiles
# - Supports macOS and Linux (apt/dnf/yum/pacman/zypper, or Homebrew if present)
# - Installs: git, neovim, tmux, midnight-commander, fzf, ripgrep, curl, python3(+venv)
# - Sets up configs via symlinks with backups
# - Installs vim-plug and Neovim plugins
# - Installs TPM and Tmux plugins
# - Optionally bootstraps a Python venv for Neovim helpers (doq, yapf)

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS_NAME="$(uname -s)"

log_step()  { printf "\n==> %s\n" "$*"; }
log_info()  { printf "    %s\n" "$*"; }
log_ok()    { printf "✔ %s\n" "$*"; }
log_warn()  { printf "⚠ %s\n" "$*"; }
log_error() { printf "✖ %s\n" "$*"; }

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    return 1
  fi
}

# Determine package manager and install commands
PM=""
PM_UPDATE=""
PM_INSTALL=""

choose_package_manager() {
  if require_cmd brew; then
    PM="brew"
    PM_UPDATE="brew update"
    PM_INSTALL="brew install"
    return
  fi

  # Linux managers
  if require_cmd apt-get || require_cmd apt; then
    PM="apt"
    PM_UPDATE="sudo apt-get update -y"
    PM_INSTALL="sudo apt-get install -y"
    return
  fi
  if require_cmd dnf; then
    PM="dnf"
    PM_UPDATE="sudo dnf -y update || true"
    PM_INSTALL="sudo dnf -y install"
    return
  fi
  if require_cmd yum; then
    PM="yum"
    PM_UPDATE="sudo yum -y update || true"
    PM_INSTALL="sudo yum -y install"
    return
  fi
  if require_cmd pacman; then
    PM="pacman"
    PM_UPDATE="sudo pacman -Sy --noconfirm"
    PM_INSTALL="sudo pacman -S --noconfirm --needed"
    return
  fi
  if require_cmd zypper; then
    PM="zypper"
    PM_UPDATE="sudo zypper -n refresh"
    PM_INSTALL="sudo zypper -n install"
    return
  fi
}

ensure_homebrew_on_macos() {
  if [[ "$OS_NAME" == "Darwin" ]] && ! require_cmd brew; then
    log_step "Installing Homebrew (macOS)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Activate brew in current shell
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  fi
}

install_packages() {
  log_step "Installing packages using: $PM"
  eval "$PM_UPDATE"

  case "$PM" in
    brew)
      eval "$PM_INSTALL git neovim tmux midnight-commander fzf ripgrep curl python" || true
      ;;
    apt)
      # Ensure curl for later stages
      eval "$PM_INSTALL curl"
      # Core packages
      eval "$PM_INSTALL git neovim tmux mc fzf ripgrep python3 python3-venv"
      ;;
    dnf|yum)
      eval "$PM_INSTALL git neovim tmux mc fzf ripgrep curl python3 python3-pip" || true
      ;;
    pacman)
      eval "$PM_INSTALL git neovim tmux mc fzf ripgrep curl python"
      ;;
    zypper)
      eval "$PM_INSTALL git neovim tmux mc fzf ripgrep curl python3 python3-pip" || true
      ;;
    *)
      log_warn "Unknown package manager. Skipping package installation. Ensure dependencies are installed manually."
      ;;
  esac
}

backup_and_link() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [[ -e "$dest" || -L "$dest" ]]; then
    local ts
    ts="$(date +%Y%m%d%H%M%S)"
    log_info "Backing up existing: $dest -> ${dest}.bak_${ts}"
    mv -f "$dest" "${dest}.bak_${ts}"
  fi

  ln -s "$src" "$dest"
  log_ok "Linked $(basename "$src") -> $dest"
}

setup_git() {
  log_step "Configuring Git"
  backup_and_link "$REPO_DIR/git/gitconfig" "$HOME/.gitconfig"
}

install_vim_plug() {
  local plug_path
  plug_path="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"

  if [[ ! -f "$plug_path" ]]; then
    log_info "Installing vim-plug to: $plug_path"
    curl -fLo "$plug_path" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  else
    log_info "vim-plug already present"
  fi
}

setup_python_env_for_nvim() {
  # Optional: create a small venv for tools referenced by init.vim (doq, yapf)
  if command -v python3 >/dev/null 2>&1; then
    local venv_dir="$HOME/.config/nvim/env"
    if [[ ! -d "$venv_dir" ]]; then
      log_info "Creating Python venv for Neovim tools: $venv_dir"
      python3 -m venv "$venv_dir" || { log_warn "Failed to create Python venv"; return; }
    fi
    "$venv_dir/bin/python" -m pip install --upgrade pip setuptools wheel || true
    "$venv_dir/bin/pip" install --upgrade doq yapf || true
    log_ok "Python tools installed in venv (doq, yapf)"
  else
    log_warn "python3 not found; skipping Neovim helper venv (doq, yapf)"
  fi
}

setup_nvim() {
  log_step "Configuring Neovim"
  backup_and_link "$REPO_DIR/nvim/init.vim" "$HOME/.config/nvim/init.vim"
  install_vim_plug
  setup_python_env_for_nvim

  if command -v nvim >/dev/null 2>&1; then
    log_info "Installing Neovim plugins (headless)"
    nvim --headless +PlugInstall +qall || log_warn "Plugin installation encountered issues; you can retry inside Neovim with :PlugInstall"
  else
    log_warn "Neovim (nvim) not in PATH; skipping plugin installation"
  fi
}

setup_tmux() {
  log_step "Configuring Tmux"
  backup_and_link "$REPO_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

  # Legacy shim to source XDG config
  if [[ ! -e "$HOME/.tmux.conf" && ! -L "$HOME/.tmux.conf" ]]; then
    printf "source-file ~/.config/tmux/tmux.conf\n" > "$HOME/.tmux.conf"
    log_ok "Created ~/.tmux.conf to source XDG config"
  fi

  # Install TPM
  local tpm_dir="$HOME/.tmux/plugins/tpm"
  if [[ ! -d "$tpm_dir" ]]; then
    log_info "Installing TPM to $tpm_dir"
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
  else
    log_info "TPM already installed"
  fi

  if command -v tmux >/dev/null 2>&1; then
    log_info "Installing Tmux plugins via TPM"
    "$tpm_dir/bin/install_plugins" || log_warn "TPM install failed; open tmux and press Prefix (Ctrl-Space) then I to install"
  else
    log_warn "tmux not in PATH; skipping TPM plugin installation"
  fi
}

setup_mc() {
  log_step "Configuring Midnight Commander"
  backup_and_link "$REPO_DIR/midnight-commander/ini" "$HOME/.config/mc/ini"

  # Legacy location symlink for compatibility
  if [[ ! -e "$HOME/.mc/ini" && ! -L "$HOME/.mc/ini" ]]; then
    mkdir -p "$HOME/.mc"
    ln -s "$HOME/.config/mc/ini" "$HOME/.mc/ini"
    log_ok "Linked legacy ~/.mc/ini -> ~/.config/mc/ini"
  fi
}

main() {
  log_step "Detecting platform"
  log_info "OS: $OS_NAME"

  # If macOS and brew missing, install it; otherwise choose existing manager
  ensure_homebrew_on_macos || true
  choose_package_manager || true

  if [[ -n "$PM" ]]; then
    install_packages
  else
    log_warn "No supported package manager detected. Skipping package installation."
  fi

  setup_git
  setup_nvim
  setup_tmux
  setup_mc

  log_step "All done!"
  log_info "- Git config:        ~/.gitconfig"
  log_info "- Neovim config:     ~/.config/nvim/init.vim"
  log_info "- Tmux config:       ~/.config/tmux/tmux.conf (and ~/.tmux.conf shim)"
  log_info "- Midnight Commander: ~/.config/mc/ini (and legacy ~/.mc/ini symlink)"

  log_info "Next steps:"
  log_info "- Open Neovim to verify plugins and theme: nvim"
  log_info "- Start tmux and press Ctrl-Space then I to install/update plugins if needed"
  log_info "- Launch Midnight Commander: mc"
}

main "$@"
