### Alias
```bash
git config --global alias.slog "log --oneline --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(green)%ar%C(reset) %C(white)%s%C(reset) %C(dim white) by %C(bold red)%an%C(reset)%C(bold yellow)%d%C(reset)' --all"
```

### Omisión de un archivo previamente confirmado
```bash
git rm --cached debug.log
git commit -m "Start ignoring debug.log"
```

### Use with unverified https
```bash
git -c http.sslVerify=false clone https://SERVER/repo-name.git
```

### gpg signed

```bash
brew install gnupg
# One of the email addresses in the GPG public key must match a verified email address used by the committer in GitLab

gpg --full-gen-key
gpg --list-secret-keys --keyid-format LONG <EMAIL>
    sec alg/ID 
gpg --armor --export <ID>

git config --global user.signingkey <KEY ID>

git commit -S -m "My commit message"

# Sign all Git commits by default by running this command:
git config --global commit.gpgsign true

# gpg: signing failed: Inappropriate ioctl for device
export GPG_TTY=$(tty)
```
