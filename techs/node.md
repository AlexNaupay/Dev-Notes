# Nodejs

## Security
```bash
# configure npm to always ignore scripts by default (project level)
echo "ignore-scripts=true" >> .npmrc

# npm to ignore scripts by default on the system level
npm config set ignore-scripts true

npm ci --ignore-scripts



```