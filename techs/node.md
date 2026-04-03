# Nodejs

## Security
```bash
# configure npm to always ignore scripts by default (project level)
echo "ignore-scripts=true" >> .npmrc

# npm to ignore scripts by default on the system level
npm config set ignore-scripts true

npm ci --ignore-scripts

# Enforce a 7-day delay
npm config set min-release-age 7
pnpm config set minimum-release-age 10080
yarn config set npmMinimumReleaseAge 10080
uv --exclude-newer "7 days ago"

```