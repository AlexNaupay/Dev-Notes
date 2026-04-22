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

### Delete a folder from the history

```bash
# First delete from working tree and index
git rm -r --cached uploads
echo "uploads/" >> .gitignore
git add .gitignore
git commit -m "Remove uploads directory and add to gitignore"

# Delete from all commits
# https://github.com/newren/git-filter-repo/ (install git-filter-repo)
# wget https://raw.githubusercontent.com/newren/git-filter-repo/main/git-filter-repo
git filter-repo --path uploads --invert-paths
git filter-repo --path uploads --invert-paths --force
```