#!/bin/bash

# Remove all remotes containing 'fork' in their names
for remote in $(git remote); do
  if [[ $remote == *"fork"* ]]; then
    echo "Removing remote: $remote"
    git remote remove $remote
  fi
done

git pull origin main

read -p "Enter the link to the fork repository: " fork_link

git remote add fork $fork_link

git fetch fork middleAssignment

git stash

git pull fork middleAssignment

git stash pop
