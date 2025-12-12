#!/bin/sh

BRANCH="${BRANCH:-master}"

############################################################################################################################
# To run this script:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/gmasse/openstack_docker_env/master/all_in_one.sh)"
# or from a specific branch:
#   BRANCH=refs/heads/dev/starship sh -c "$(curl -fsSL https://raw.githubusercontent.com/gmasse/openstack_docker_env/\${BRANCH}/all_in_one.sh)"
#


for commandname in git curl zsh; do
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

# Installing Starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$HOME/.local/bin"

mkdir -p ~/.config && touch ~/.config/starship.toml

# Downloading some zsh plugins
mkdir -p "$HOME/.my-custom-zsh"
git clone --depth 1 'https://github.com/z-shell/F-Sy-H' "$HOME/.my-custom-zsh/f-sy-h"
git clone --depth 1 'https://github.com/zsh-users/zsh-autosuggestions' "$HOME/.my-custom-zsh/zsh-autosuggestions"
git clone --depth 1 'https://github.com/zsh-users/zsh-history-substring-search' "$HOME/.my-custom-zsh/zsh-history-substring-search"


# Configuring zsh
curl -fsSL -o ~/.zshrc https://raw.githubusercontent.com/gmasse/openstack_docker_env/${BRANCH}/zshrc


# Installing vim packages (editorconfig, vim-airline w/ Solarized theme, indentLine)
mkdir -p ~/.vim/pack/dist/start/
mkdir -p ~/.vim/pack/themes/opt/
git clone https://github.com/editorconfig/editorconfig-vim.git ~/.vim/pack/dist/start/editorconfig-vim
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/pack/dist/start/vim-airline-themes
git clone https://github.com/altercation/vim-colors-solarized ~/.vim/pack/themes/opt/vim-colors-solarized
git clone https://github.com/Yggdroot/indentLine.git ~/.vim/pack/dist/start/indentLine
curl -fsSL -o ~/.vimrc https://raw.githubusercontent.com/gmasse/openstack_docker_env/${BRANCH}/vimrc

