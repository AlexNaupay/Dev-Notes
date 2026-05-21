#!/usr/bin/env bash
 
set -e

sudo apt install zsh git -y
#chsh -s $(which zsh)

# OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# setup plugins
sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting colorize)/' ~/.zshrc

# ~/.zshrc  | theme: agnoster
# gnzh : New line 
# cypher : Host :: Full path, but no git (For servers)
# kafeitu : ➜ user@host full path with git 
# af-magic : Full path with git
# awesomepanda : ➜ Last directory with git
# cloud, miloshadzic : Clean
# half-life : Nice
omz theme set kafeitu
