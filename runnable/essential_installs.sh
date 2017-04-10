#!/usr/bin/env bash

# Installs Homebrew and some of the common dependencies needed/desired for software development
if test ! $(which brew)
then
    echo "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Install Caskroom
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

# Install the usual Homebrew packages

brew install python
brew install python3
brew cask install java
brew cask install java-jdk-javadoc
brew install git
brew install gist
brew install git-extras
brew install node
brew install scala
brew install sbt
brew install vim --with-override-system-vi
brew install go
brew install wget --with-iri
brew install maven
brew install readline
brew install grunt
brew install wallpaper


brew cask install adobe-reader
brew cask install advancedcolors
brew cask install appcleaner
brew cask install cakebrew
brew cask install flash-player
brew cask install google-chrome
brew cask install google-featured-photos
brew cask install google-hangouts
brew cask install gulp
brew cask install material-colors
brew cask install microsoft-office
brew cask install postman
brew cask install simplenote
brew cask install skyfonts
brew cask install skype
brew cask install tiny
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install whatsapp

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch qlvideo qlplayground qlswift quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
