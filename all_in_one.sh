#!/bin/sh

#############################################################################################################
# To run this script:
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/gmasse/openstack_docker_env/master/all_in_one.sh)"
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

# Installing Oh My Zsh
CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Downloading some zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Downloading customized Agnoster theme
curl -fsSL -o ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/agnoster.zsh-theme https://raw.githubusercontent.com/gmasse/agnoster-zsh-theme/master/agnoster.zsh-theme

# Configuring zsh
curl -fsSL -o ~/.zshrc https://raw.githubusercontent.com/gmasse/openstack_docker_env/master/zshrc


# Installing vim packages (editorconfig, vim-airline w/ Solarized theme)
mkdir -p ~/.vim/pack/dist/start/
mkdir -p ~/.vim/pack/themes/opt/
git clone https://github.com/editorconfig/editorconfig-vim.git ~/.vim/pack/dist/start/editorconfig-vim
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/pack/dist/start/vim-airline-themes
git clone https://github.com/altercation/vim-colors-solarized ~/.vim/pack/themes/opt/vim-colors-solarized
curl -fsSL -o ~/.vimrc https://raw.githubusercontent.com/gmasse/openstack_docker_env/master/vimrc


#chsh -s $(command -pv zsh)
#if chsh return PAM error, have a look at https://serverfault.com/questions/202468/changing-the-shell-using-chsh-via-the-command-line-in-a-script
