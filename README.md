# Mick's Dot Files
This is a private repo to hold my dotfiles. 

Files are for:
 * nvim (with associated plugins)
 * Midnight Commander
 * tmux

Configuration guide to-be-written.

Plugin Manager needs to be installed.


## Sane Github settings
Here are some Github config settings that should be set by default. Comes from [this page](https://spin.atomicobject.com/2020/05/05/git-configurations-default/).
``` bash
git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.colorMoved zebra
```
## Tmux settings
Tmux was set up with the aid of this [video](https://youtu.be/DzNmUNvnB04). You will need to copy the conf file to the appropriate location in your homedrive so that Tmux can pick it up. In my case, that was `~/.config/tmux/` folder. Secondly, install [TPM](https://github.com/tmux-plugins/tpm) as the Tmux Plugin Manager. You can source the new configuration file by typing `tmux source <your conf location>`. Then open Tmux by typing `tmux` at the command prompt. Once in tmux, install the plugins using `<leader key> I`.

The leader key in my confiration is **Ctl + Space**. 

Here are a list of useful commands that will help:
 * `<leader key> + c` - Create a new window
 * `<leader key> + ,` - rename the window
 * `<leader key> + |` - create a new pane vertically split
 * `<leader key> + -` - create a new pane horizontal split
 * `<leader key> + Arrow Key` - navigate between panes
 * `Shift + left/right arrow keys` - switch between windows
 * `<leader key> + [` - move the cursor around the screen. There are vim bindings for selection
 * `<leader key> + s` - show all sessions
 * `<leader key> + w` - show all sessions with windows
 * `<leader key> + z` - zoom current pane to take up the entire window
 * `<leader key> + d` - disconnect from tmux
