#!/bin/bash

for remote in $(git remote); do
  if [[ $remote == *"fork"* ]]; then
    echo "Removing remote: $remote"
    git remote remove $remote
  fi
done

git pull origin main

git reset --hard b4b9f801f873f41789087554eb1eddf30fff72c9

read -p "Enter the link to the fork repository: " fork_link

git remote add fork $fork_link

git fetch fork middleAssignment

git stash

git pull fork middleAssignment


