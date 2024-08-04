#!/bin/bash
set -e

rsync -a --delete --exclude .git --exclude .gitignore --exclude repo.json ../master/repo/ .
git config --global user.email "aniyomi-bot@aniyomi.org"
git config --global user.name "aniyomi-bot[bot]"
git status
if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -S -m "Update extensions repo"
    git push

    # Purge cached index on jsDelivr
    curl https://purge.jsdelivr.net/gh/ni3x/aniyomi-extensions@repo/index.min.json
else
    echo "No changes to commit"
fi
