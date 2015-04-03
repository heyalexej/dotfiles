#!/usr/bin/env bash

# - http://vim.wikia.com/wiki/Building_Vim
# - https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
# - http://kowalcj0.wordpress.com/2013/11/19/how-to-compile-and-install-latest-version-of-vim-with-support-for-x11-clipboard-ruby-python-2-3/
# - http://blog.sanctum.geek.nz/vim-as-debian-default/
# - https://github.com/genoma/source-vim
# - https://github.com/BenjaminRH/vim-installer/blob/master/vim_installer.sh
# - https://github.com/faouellet/vimconfig/blob/dc15ea0ad5fd4153c2d5c3aed6d5208f783a2d82/install.sh
# - https://github.com/uchiha-yuki/.vim/blob/5fdab3bcbbfd783c38d0476d3e06a4720bb5ae7e/install_ycm.sh
# - https://github.com/Valloric/YouCompleteMe/issues/28#issuecomment-52196202
# - https://carbonscott.wordpress.com/2015/01/21/youcompleteme-plugin-for-vim/

# VIM_REPO_URL="https://vim.googlecode.com/hg/"
VIM_REPO_URL="https://code.google.com/p/vim/"
VIM_SRC_PATH="$HOME/.local/src/vim"
VIM_BIN_PATH="/usr/local/bin/vim"

PKGNAME="vim-custom"
AUTHOR="$(getent passwd "$(whoami)" | cut -d ':' -f 5 | cut -d ',' -f 1)"

# TODO: This will fail on non-ubuntu distros, fix it.
if [[ "$OSTYPE" == *linux* ]]; then
  
  echo "removing any previous vim installations ..."
  sudo apt-get remove vim-tiny vim-common vim-gui-common vim vim-nox

  echo "installing build tools ..."
  sudo apt-get -y install build-essential checkinstall python-dev mercurial

  echo "installing vim dependencies ..."
  sudo apt-get -y build-dep vim

  echo "installing vimrc dependencies ..."
  sudo apt-get -y install silversearcher-ag curl exuberant-ctags xclip

elif [[ "OSTYPE" == *darwin ]]; then

  echo "installing build tools ..."
  brew install mercurial

fi


# hg clone https://code.google.com/p/vim/ ~/.local/src/vim
if [[ ! -d "$VIM_SRC_PATH" ]]; then

  echo "downloading source ..."
  hg clone "$VIM_REPO_URL" "$VIM_SRC_PATH" || return 1

else

  echo "updating source ..."
  hg update "$VIM_SRC_PATH" || return 1

fi

return 0

echo "compiling ..."
cd ~/.local/src/vim
./configure --with-features=huge \
  --enable-gui=no \
  --enable-cscope \
  --enable-multibyte \
  --enable-luainterp \
  --enable-perlinterp \
  --enable-rubyinterp \
  --enable-pythoninterp \
  --with-python-config-dir="$(python2.7-config --configdir)" \
  --prefix=/usr/local \
  --with-compiledby="$AUTHOR"
# --with-x
# --with-client-server


if [[ "$OSTYPE" == *linux* ]]; then

  echo "building ..."
  make VIMRUNTIMEDIR=/usr/local/share/vim/vim74

  echo "installing ..."
  sudo checkinstall \
    --default \
    --pkgname=$PKGNAME

  echo "setting as default editor ..."
  sudo update-alternatives --install /usr/bin/editor editor "$VIM_BIN_PATH" 1
  sudo update-alternatives --set editor "$VIM_BIN_PATH"

  sudo update-alternatives --install /usr/bin/vim vim "$VIM_BIN_PATH" 1
  sudo update-alternatives --set vim "$VIM_BIN_PATH"

  sudo update-alternatives --install /usr/bin/vi vi "$VIM_BIN_PATH" 1
  sudo update-alternatives --set vi "$VIM_BIN_PATH"


#  echo "installing vam & youcompleteme"
#  sudo apt-get install vim-addon-manager
#  sudo apt-get install vim-youcompleteme
#  vam install youcompleteme
fi

