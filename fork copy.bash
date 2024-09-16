#!/bin/bash

for remote in $(git remote); do
  if [[ $remote == *"fork"* ]]; then
    echo "Removing remote: $remote"
    git remote remove $remote
  fi
done

git pull origin main

git reset --hard 5dff470f232da331f32be8fa86d21da00101e6e1

read -p "Enter the link to the fork repository: " fork_link

git remote add fork $fork_link

git fetch fork middleAssignment

git stash

git pull fork middleAssignment


