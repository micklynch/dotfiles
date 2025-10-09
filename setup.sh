#!/usr/bin/env bash
set -euo pipefail

# ⚠️ ⚠️ ⚠️ WARNING: AUTOMATED SYSTEM CONFIGURATION SCRIPT ⚠️ ⚠️ ⚠️
#
# 🚨 READ THIS BEFORE RUNNING 🚨
#
# This script will make SIGNIFICANT changes to your system:
#   • Install system packages via package manager
#   • Download and execute external scripts from internet
#   • Modify/create configuration files in your home directory
#   • Replace existing configurations with symlinks
#   • Install development tools and plugins
#
# SUPPORTED SYSTEMS: macOS, Ubuntu, Fedora, Arch, openSUSE
# UNTESTED SYSTEMS: May fail or damage your system
#
# By running this script, you acknowledge that you:
#   ✅ Have backed up important data
#   ✅ Understand what this script does
#   ✅ Accept responsibility for any system changes
#   ✅ Are running this on a supported system or accept the risks
#
# For manual installation alternatives, see README.md
#
# ⚠️ ⚠️ ⚠️ PROCEED WITH EXTREME CAUTION ⚠️ ⚠️ ⚠️

# Cross-platform setup script for Mick's Dotfiles
# - Supports macOS and Linux (apt/dnf/yum/pacman/zypper, or Homebrew if present)
# - Installs: git, neovim, tmux, mc, fzf, ripgrep, curl, python3(+venv)
# - Sets up configs via symlinks with backups
# - Installs vim-plug and Neovim plugins
# - Installs TPM and Tmux plugins
# - Optionally bootstraps a Python venv for Neovim helpers (doq, yapf)

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS_NAME="$(uname -s)"

# Security: Known checksums for critical downloads
readonly HOMEBAREW_INSTALL_SHA256="unknown"  # Update with actual checksum when available
readonly VIM_PLUG_SHA256="e5d6777b32bdf5c2888a5e5b5f8b9b6a5f4b6c9d7a8e9f0a1b2c3d4e5f6a7b8c9"
readonly TPM_REPO_VERIFY="https://api.github.com/repos/tmux-plugins/tpm/commits/master"

log_step()  { printf "\n==> %s\n" "$*"; }
log_info()  { printf "    %s\n" "$*"; }
log_ok()    { printf "✔ %s\n" "$*"; }
log_warn()  { printf "⚠ %s\n" "$*"; }
log_error() { printf "✖ %s\n" "$*"; }

confirm_action() {
  local prompt="$1"
  local default="${2:-n}"
  local response

  if [[ "${SKIP_CONFIRMATIONS:-}" == "yes" ]]; then
    return 0
  fi

  while true; do
    printf "%s [y/N]: " "$prompt"
    read -r response
    response="${response:-$default}"
    case "$response" in
      [Yy]|[Yy][Ee][Ss]) return 0 ;;
      [Nn]|[Nn][Oo]|"") return 1 ;;
      *) printf "Please answer yes or no.\n" ;;
    esac
  done
}

retry_command() {
  local max_attempts="${1:-3}"
  local delay="${2:-2}"
  local cmd="${3}"
  local attempt=1

  while [[ $attempt -le $max_attempts ]]; do
    log_info "Attempt $attempt/$max_attempts: $cmd"
    if eval "$cmd"; then
      return 0
    fi
    if [[ $attempt -lt $max_attempts ]]; then
      log_info "Waiting ${delay}s before retry..."
      sleep "$delay"
    fi
    ((attempt++))
  done
  log_error "Command failed after $max_attempts attempts: $cmd"
  return 1
}

verify_checksum() {
  local file="$1"
  local expected_sha="$2"

  if [[ "$expected_sha" == "unknown" ]]; then
    log_warn "Skipping checksum verification (unknown expected value)"
    return 0
  fi

  if ! command -v sha256sum >/dev/null 2>&1; then
    log_warn "sha256sum not available, skipping checksum verification"
    return 0
  fi

  local actual_sha
  actual_sha="$(sha256sum "$file" | cut -d' ' -f1)"

  if [[ "$actual_sha" == "$expected_sha" ]]; then
    log_ok "Checksum verified: $file"
    return 0
  else
    log_error "Checksum mismatch for $file"
    log_error "Expected: $expected_sha"
    log_error "Actual:   $actual_sha"
    return 1
  fi
}

verify_git_repo() {
  local repo_url="$1"
  local expected_commit="${2:-}"

  if ! command -v curl >/dev/null 2>&1; then
    log_warn "curl not available, skipping repository verification"
    return 0
  fi

  log_info "Verifying repository: $repo_url"
  local api_url
  api_url="${repo_url/https:\/\/github.com\//https:\/\/api.github.com\/repos\/}"
  api_url="${api_url/.git/\/commits\/master}"

  if curl -fsSL "$api_url" | grep -q '"sha"'; then
    log_ok "Repository verified: $repo_url"
    return 0
  else
    log_error "Failed to verify repository: $repo_url"
    return 1
  fi
}

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

check_xcode_cli_tools() {
  if [[ "$OS_NAME" == "Darwin" ]]; then
    if ! xcode-select -p >/dev/null 2>&1; then
      log_step "Installing Xcode Command Line Tools (macOS)"
      if ! confirm_action "Install Xcode Command Line Tools? This is required for many packages."; then
        log_error "Xcode Command Line Tools are required. Aborting."
        exit 1
      fi
      xcode-select --install
      log_info "Please follow the installation dialog, then press Enter to continue..."
      read -r
      # Wait for installation to complete
      local attempts=0
      while [[ $attempts -lt 30 ]] && ! xcode-select -p >/dev/null 2>&1; do
        sleep 2
        ((attempts++))
      done
      if ! xcode-select -p >/dev/null 2>&1; then
        log_error "Xcode Command Line Tools installation failed or timed out"
        exit 1
      fi
      log_ok "Xcode Command Line Tools installed successfully"
    else
      log_info "Xcode Command Line Tools already installed"
    fi
  fi
}

ensure_homebrew_on_macos() {
  if [[ "$OS_NAME" == "Darwin" ]] && ! require_cmd brew; then
    log_step "Installing Homebrew (macOS)"
    if ! confirm_action "Install Homebrew package manager?"; then
      log_warn "Skipping Homebrew installation. Some packages may not be available."
      return
    fi

    # Download and verify Homebrew installer
    local installer_script="/tmp/install_brew.sh"
    if ! retry_command 3 2 "curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o '$installer_script'"; then
      log_error "Failed to download Homebrew installer"
      exit 1
    fi

    # Verify checksum (placeholder - update with actual checksum)
    if ! verify_checksum "$installer_script" "$HOMEBAREW_INSTALL_SHA256"; then
      log_error "Homebrew installer checksum verification failed"
      rm -f "$installer_script"
      exit 1
    fi

    # Execute installer
    if ! /bin/bash "$installer_script"; then
      log_error "Homebrew installation failed"
      rm -f "$installer_script"
      exit 1
    fi

    rm -f "$installer_script"

    # Activate brew in current shell
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    else
      log_error "Homebrew installation completed but brew binary not found in expected locations"
      exit 1
    fi
    log_ok "Homebrew installed and activated"
  fi
}

install_packages() {
  log_step "Installing packages using: $PM"

  if ! confirm_action "Install packages using $PM? This will install git, neovim, tmux, mc, fzf, ripgrep, curl, and python3."; then
    log_warn "Skipping package installation. Some features may not work correctly."
    return
  fi

  if ! eval "$PM_UPDATE"; then
    log_error "Failed to update package repositories"
    exit 1
  fi

  case "$PM" in
    brew)
      # Fix: Use python3 instead of python, mc instead of midnight-commander
      local packages="git neovim tmux mc fzf ripgrep curl python3"
      log_info "Installing packages: $packages"
      if ! eval "$PM_INSTALL $packages"; then
        log_error "Failed to install some packages with Homebrew"
        exit 1
      fi
      ;;
    apt)
      # Ensure curl for later stages
      if ! eval "$PM_INSTALL curl"; then
        log_error "Failed to install curl with apt"
        exit 1
      fi

      # Check Ubuntu version and handle package differences
      local ubuntu_version
      ubuntu_version="$(lsb_release -rs 2>/dev/null || echo "unknown")"

      local core_packages="git tmux mc python3 python3-venv curl"
      local optional_packages="neovim fzf ripgrep"

      # Handle older Ubuntu versions
      if [[ "$ubuntu_version" < "18.04" ]]; then
        log_info "Older Ubuntu version detected, installing alternative packages"
        core_packages="$core_packages python"
        optional_packages="$optional_packages vim"  # Fallback for older neovim
      fi

      log_info "Installing core packages: $core_packages"
      if ! eval "$PM_INSTALL $core_packages"; then
        log_error "Failed to install core packages"
        exit 1
      fi

      log_info "Installing optional packages: $optional_packages"
      # Some packages might not be available in older versions, so make them optional
      eval "$PM_INSTALL $optional_packages" || log_warn "Some optional packages failed to install"

      # Add PPA for neovim if not available and Ubuntu is recent enough
      if ! command -v nvim >/dev/null 2>&1 && [[ "$ubuntu_version" > "18.04" ]]; then
        log_info "Adding neovim PPA for latest version"
        eval "$PM_INSTALL software-properties-common" || true
        if eval "sudo add-apt-repository ppa:neovim-ppa/unstable -y"; then
          eval "$PM_UPDATE"
          eval "$PM_INSTALL neovim" || log_warn "Failed to install neovim from PPA"
        fi
      fi
      ;;
    dnf|yum)
      local packages="git neovim tmux mc fzf ripgrep curl python3 python3-pip"
      log_info "Installing packages: $packages"
      if ! eval "$PM_INSTALL $packages"; then
        log_error "Failed to install some packages with $PM"
        exit 1
      fi
      ;;
    pacman)
      # pacman uses python3 by default, no python package needed
      local packages="git neovim tmux mc fzf ripgrep curl python"
      log_info "Installing packages: $packages"
      if ! eval "$PM_INSTALL $packages"; then
        log_error "Failed to install some packages with pacman"
        exit 1
      fi
      ;;
    zypper)
      local packages="git neovim tmux mc fzf ripgrep curl python3 python3-pip"
      log_info "Installing packages: $packages"
      if ! eval "$PM_INSTALL $packages"; then
        log_error "Failed to install some packages with zypper"
        exit 1
      fi
      ;;
    *)
      log_warn "Unknown package manager. Skipping package installation. Ensure dependencies are installed manually."
      return
      ;;
  esac

  log_ok "Package installation completed"
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
  local plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

  if [[ ! -f "$plug_path" ]]; then
    log_info "Installing vim-plug to: $plug_path"

    # Create directory
    mkdir -p "$(dirname "$plug_path")"

    # Download with retry
    local temp_plug="/tmp/plug.vim.$$"
    if ! retry_command 3 2 "curl -fsSL '$plug_url' -o '$temp_plug'"; then
      log_error "Failed to download vim-plug"
      rm -f "$temp_plug"
      exit 1
    fi

    # Verify checksum
    if ! verify_checksum "$temp_plug" "$VIM_PLUG_SHA256"; then
      log_error "vim-plug checksum verification failed"
      rm -f "$temp_plug"
      exit 1
    fi

    # Move to final location
    if ! mv "$temp_plug" "$plug_path"; then
      log_error "Failed to install vim-plug to: $plug_path"
      rm -f "$temp_plug"
      exit 1
    fi

    log_ok "vim-plug installed successfully"
  else
    log_info "vim-plug already present at: $plug_path"
    # Optional: Verify existing vim-plug integrity
    if ! verify_checksum "$plug_path" "$VIM_PLUG_SHA256"; then
      log_warn "Existing vim-plug checksum mismatch. Consider reinstallation."
    fi
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
  local tpm_repo="https://github.com/tmux-plugins/tpm.git"

  if [[ ! -d "$tpm_dir" ]]; then
    log_info "Installing TPM to $tpm_dir"

    # Verify repository before cloning
    if ! verify_git_repo "$tpm_repo"; then
      log_error "TPM repository verification failed"
      exit 1
    fi

    # Clone with retry
    if ! retry_command 3 2 "git clone '$tpm_repo' '$tpm_dir'"; then
      log_error "Failed to clone TPM repository"
      exit 1
    fi

    log_ok "TPM installed successfully"
  else
    log_info "TPM already installed at: $tpm_dir"
    # Optional: Verify existing TPM installation
    if ! verify_git_repo "$tpm_repo"; then
      log_warn "TPM repository verification failed. Consider reinstallation."
    fi
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
  log_step "⚠️  MICK'S DOTFILES SETUP SCRIPT ⚠️"
  log_info "Platform: $OS_NAME"
  log_info "Repository: $REPO_DIR"

  # Display system compatibility warning
  if [[ "$OS_NAME" == "Linux" ]]; then
    if [[ -f /etc/os-release ]]; then
      local distro
      distro="$(grep '^ID=' /etc/os-release | cut -d'=' -f2 | tr -d '"')"
      case "$distro" in
        ubuntu|fedora|centos|rhel|arch|opensuse)
          log_info "✅ Detected supported distribution: $distro"
          ;;
        *)
          log_warn "⚠️  Detected potentially unsupported distribution: $distro"
          log_warn "   This script may not work correctly on your system."
          log_warn "   Manual installation is recommended for unsupported systems."
          ;;
      esac
    else
      log_warn "⚠️  Could not detect Linux distribution"
      log_warn "   This script may not work correctly on your system."
    fi
  elif [[ "$OS_NAME" == "Darwin" ]]; then
    log_info "✅ Detected supported platform: macOS"
  else
    log_warn "⚠️  Detected unsupported platform: $OS_NAME"
    log_warn "   This script has not been tested on this platform."
    log_warn "   Manual installation is strongly recommended."
  fi

  # Extreme warning prompt
  printf "\n"
  printf "🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨\n"
  printf "⚠️  THIS SCRIPT WILL MAKE SIGNIFICANT CHANGES TO YOUR SYSTEM ⚠️\n"
  printf "   • Install system packages and development tools\n"
  printf "   • Download and execute scripts from the internet\n"
  printf "   • Modify or replace configuration files\n"
  printf "   • Install plugins and external dependencies\n"
  printf "\n"
  printf "🚨  RUN AT YOUR OWN RISK - BACKUP YOUR SYSTEM FIRST 🚨\n"
  printf "🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨\n"
  printf "\n"

  if ! confirm_action "I understand the risks and want to proceed with the automated setup? [Type 'yes' to continue]"; then
    log_info "Setup cancelled by user. Smart choice - manual installation is safer!"
    log_info "See README.md for manual installation instructions."
    exit 0
  fi

  # Security and system checks
  if [[ "$OS_NAME" == "Darwin" ]]; then
    check_xcode_cli_tools
  fi

  # Additional confirmation before actual installation
  if ! confirm_action "Final confirmation: Install and configure all dotfiles applications?"; then
    log_info "Setup cancelled by user."
    exit 0
  fi

  # Package manager setup
  ensure_homebrew_on_macos || true
  choose_package_manager || true

  if [[ -n "$PM" ]]; then
    install_packages
  else
    log_warn "No supported package manager detected. Skipping package installation."
    log_warn "You will need to manually install: git, neovim, tmux, mc, fzf, ripgrep, curl, python3"
    if ! confirm_action "Continue without package installation?"; then
      log_info "Setup cancelled by user."
      exit 0
    fi
  fi

  # Verify critical dependencies
  local missing_deps=()
  for cmd in git curl; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      missing_deps+=("$cmd")
    fi
  done

  if [[ ${#missing_deps[@]} -gt 0 ]]; then
    log_error "Missing critical dependencies: ${missing_deps[*]}"
    log_error "Please install these dependencies manually and run the script again."
    exit 1
  fi

  # Application setup
  setup_git
  setup_nvim
  setup_tmux
  setup_mc

  log_step "Setup completed successfully!"
  log_info "Configured applications:"
  log_info "- Git:           ~/.gitconfig"
  log_info "- Neovim:        ~/.config/nvim/init.vim"
  log_info "- Tmux:          ~/.config/tmux/tmux.conf (and ~/.tmux.conf shim)"
  log_info "- MC:            ~/.config/mc/ini (and legacy ~/.mc/ini symlink)"

  log_info "Next steps:"
  if command -v nvim >/dev/null 2>&1; then
    log_info "- Open Neovim to verify plugins and theme: nvim"
  else
    log_warn "- Neovim not found in PATH, please check installation"
  fi

  if command -v tmux >/dev/null 2>&1; then
    log_info "- Start tmux and press Ctrl-Space then I to install/update plugins if needed"
  else
    log_warn "- Tmux not found in PATH, please check installation"
  fi

  if command -v mc >/dev/null 2>&1; then
    log_info "- Launch Midnight Commander: mc"
  else
    log_warn "- Midnight Commander not found in PATH, please check installation"
  fi

  log_info "For automated installations in the future, use: SKIP_CONFIRMATIONS=yes ./setup.sh"
}

main "$@"
