# ZSH

```bash
apt install zsh
chsh -s $(which zsh)

# OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# ~/.zshrc  | theme: agnoster, cypher, dstufft,gnzh, kafeitu 
omz theme set cypher

plugins=(
git
zsh-autosuggestions
zsh-syntax-highlighting
colorize
)
```

## References
[OhMyZsh](https://github.com/ohmyzsh/ohmyzsh/blob/master/README.md)

[Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)

[zsh-users](https://github.com/zsh-users)

[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)