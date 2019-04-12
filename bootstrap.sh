#!/usr/bin/env bash

echo 'Welcome! Before you start, please make sure that:'
echo '- You are using Linux Mint (this script might also work on Ubuntu, but it has not been tested there)'
echo '- You checked the configuration files and adjusted them to your needs'
echo

read -p 'Ready to start? (y/n)? ' CONT
if [ "$CONT" = 'y' ]; then
        echo '› Installing necessary packages'
        echo

        sudo apt-get update
        sudo apt install zsh curl nodejs npm git

        echo
        echo '› Verifying zsh installation'
        echo


        if zsh --version | grep -q 'zsh'; then
            echo '✔︎ zsh successfully installed'
        fi

        echo
        echo '› Making zsh a default shell'
        echo

        chsh -s $(which zsh)

        if echo $SHELL | grep -q 'zsh'; then
            echo '✔ ︎zsh is now a default shell'
        fi

        echo
        echo '› Installing oh-my-zsh'
        echo

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

        echo
        echo '› Copying zsh configuration file';
        echo

        cp -f .zshrc ~/

        echo
        echo '› Installing zsh-syntax-highlighting plugin'
        echo

        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

        echo
        echo '› Verifying npm installation'
        echo

        if npm --help | grep -q 'doctor'; then
            echo '✔︎ npm successfully installed'
        fi

        echo
        echo '› Installing pure prompt'
        echo '› An error may occur during this installation, do not worry about it'
        echo

        npm install --global pure-prompt

        echo
        echo '› Copying npm configuration file & making a directory for packages'
        echo

        mkdir ~/.npm-packages
        cp -f .npmrc ~/

        zsh
        
        echo
        echo '✔︎ Done!'
        echo
else
  echo '› Exiting';
fi