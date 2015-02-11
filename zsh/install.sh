#!/bin/sh

if test ! $(which zsh)
then
  echo "Installing ZSH"
  brew install zsh > /tmp/zsh-install.log
fi

chsh -s $(which zsh)
