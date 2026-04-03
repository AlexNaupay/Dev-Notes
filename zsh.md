# ZSH

```bash
apt install zsh
chsh -s $(which zsh)

# OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# ~/.zshrc  | theme: agnoster
# gnzh : New line 
# cypher : Host :: Full path, but no git (For servers)
# kafeitu : ➜ user@host full path with git 
# af-magic : Full path with git
# awesomepanda : ➜ Last directory with git
# cloud, miloshadzic : Clean
# half-life : Nice
omz theme set cypher

plugins=(
git
zsh-autosuggestions
zsh-syntax-highlighting
colorize
)
```

### Tips
```bash
# Disable history on current session
unset HISTFILE
HISTFILE=/dev/null zsh

# This "pushes" your current history onto a stack and starts a new
# empty history in memory that is not associated with any file.
fc -p
#  to "pop" and return to your normal history, or simply exit
fc -P
```

## References
[OhMyZsh](https://github.com/ohmyzsh/ohmyzsh/blob/master/README.md)

[Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)

[zsh-users](https://github.com/zsh-users)

[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)