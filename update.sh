#!/bin/bash
echo "updating repo"
git pull origin master
echo "done"
echo "getting pathogen..."
wget https://tpo.pe/pathogen.vim > .vim/autoload/pathogen.vim
echo "done"

echo "updating submodules"
git submodule foreach git pull origin master
echo "done"
