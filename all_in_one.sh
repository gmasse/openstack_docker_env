#!/bin/bash

for commandname in git curl zsh chsh; do
  if ! [ -x "$(command -v $commandname)" ]; then
    echo "Error: $commandname is not installed." >&2
    exit 1
  fi
done

for filename in ~/.vimrc ~/.zshrc; do
  if [ -f "$filename" ]; then
    echo "Error: $filename already exists." >&2
    exit 1
  fi
done

RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/gmasse/openstack_docker_env/master/customterm.sh)"
curl -fsSL -o ~/.vimrc https://raw.githubusercontent.com/gmasse/openstack_docker_env/master/vimrc
curl -fsSL -o ~/.zshrc https://raw.githubusercontent.com/gmasse/openstack_docker_env/master/zshrc

chsh -s $(command -pv zsh)
#if chsh return PAM error, have a look at https://serverfault.com/questions/202468/changing-the-shell-using-chsh-via-the-command-line-in-a-script
