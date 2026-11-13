# Herdr

[Herdr](https://herdr.dev) is a terminal multiplexer for running multiple AI coding agents side by side. This directory holds my config.

## Install Herdr

```bash
# Official install script (Linux / macOS)
curl -fsSL https://herdr.dev/install.sh | sh

# or Homebrew
brew install herdr

# or mise
mise use -g herdr
```

Verify with `herdr --version`.

## Apply the config

```bash
mkdir -p ~/.config/herdr
cp herdr/config.toml ~/.config/herdr/config.toml
# or symlink so edits stay in the repo
ln -sf "$(pwd)/herdr/config.toml" ~/.config/herdr/config.toml
```

Restart Herdr to pick up changes.

## Customizations (`config.toml`)

| Setting | Value |
|---|---|
| Prefix key | `ctrl+space` (matches tmux) |
| Previous / next tab | `shift+left` / `shift+right` |
| Previous / next workspace | `prefix+up` / `prefix+down` |
| Split vertical / horizontal | `prefix+\|` / `prefix+minus` |
| Toggle sidebar | `prefix+m` |
| Tab bar | bottom |
| Status indicators | symbols |
| Agent labels on pane borders | hidden |
| Onboarding | disabled |

## Optional: agent integrations

For richer agent status tracking:

```bash
herdr integration install claude
```
