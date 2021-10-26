## Steps to install
1. Install the vim-plug plugin manager
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
2. Copy the init.vim file to `~/.config/nvim/` folder
3. Open up nvim, `~> nvim` and run `:PlugInstall`
