#!/bin/bash

for remote in $(git remote); do
  if [[ $remote == *"fork"* ]]; then
    echo "Removing remote: $remote"
    git remote remove $remote
  fi
done

git pull origin main

git reset --hard 1abad66cc7d979b2ee50dedd4e105286be39eb7a 

read -p "Enter the link to the fork repository: " fork_link

git remote add fork $fork_link

git fetch fork middleAssignment

git stash

git pull fork middleAssignment


