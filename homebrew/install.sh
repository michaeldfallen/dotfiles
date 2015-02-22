#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.
set -e

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Xcode, needed for macvim
xcode-select --install

#------------------------
# Taps
#------------------------

brew tap homebrew/dupes
brew tap homebrew/versions
brew tap phinze/cask
brew install brew-cask
brew tap caskroom/versions

#------------------------
# Cask Apps
#------------------------

brew cask install slack
brew cask install caffeine
brew cask install android-studio
brew cask install alfred
brew cask alfred link
brew cask install asepsis
brew cask install dropbox
brew cask install google-chrome
brew cask install lastpass
brew cask install superduper
brew cask install diffmerge
brew cask install imageoptim
brew cask install sublime-text
brew cask install pgadmin3
brew cask install postgres
brew cask install sequel-pro
brew cask install tower
brew cask install vagrant
brew cask install virtualbox
brew cask install coconutbattery
brew cask install colors
brew cask install gfxcardstatus
#brew cask install quickcast
brew cask install spectacle
brew cask install totalterminal
brew cask install chromium
brew cask install firefox
brew cask install google-chrome-canary
brew cask install opera
brew cask install cheatsheet
brew cask install dash
brew cask install evernote
brew cask install mou
brew cask install skype
brew cask install spotify

#------------------------
# Brew apps
#------------------------

brew install heroku-toolbelt
brew install macvim --override-system-vim
brew install cmake
brew install ack
brew install apple-gcc42
brew install autoconf
brew install automake
brew install gettext
brew install intltool
brew install nvm
brew install node
brew install python
brew install python3
brew install chruby
brew install ruby-install
brew install scala
brew install sbt
brew install fping
brew install git
brew install phantomjs
brew install sqlite3
brew install ansible
brew install cdrtools
brew install imagemagick
brew install jpeg
brew install terminal-notifier
brew install tree
brew install wget

#------------------------
# 
#------------------------



exit 0
