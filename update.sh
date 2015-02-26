#!/bin/bash
echo "updating repo"
git pull origin master
echo "done"

echo "updating submodules"
git submodule foreach git pull origin master
echo "done"
