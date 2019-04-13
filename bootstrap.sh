#!/usr/bin/env bash

# Colors
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
cyan=$(tput setaf 6)
normal=$(tput sgr0)

# Welcome message
echo 'Welcome! Before you start, please make sure that:'
echo '- You are using Linux Mint (this script might also work on Ubuntu, but it has not been tested there)'
echo '- You checked the configuration files and adjusted them to your needs'
echo

# Simple prompt
read -p 'Ready to start? (y/n)? ' CONT
if [ "$CONT" = 'y' ]; then
        printf "%40s\n" "${cyan}› Installing necessary packages${normal}"
        echo

        sudo apt-get update
        sudo apt install zsh curl nodejs npm git

        echo
        printf "%40s\n" "${cyan}› Verifying zsh installation${normal}"
        echo


        if zsh --version | grep -q 'zsh'; then
            printf "%40s\n" "${green}✔︎ zsh successfully installed${normal}"
        fi

        echo
        printf "%40s\n" "${cyan}› Making zsh a default shell${normal}"
        echo

        chsh -s $(which zsh)

        if echo $SHELL | grep -q 'zsh'; then
            printf "%40s\n" "${green}✔ ︎zsh is now a default shell${normal}"
        fi

        echo
        printf "%40s\n" "${cyan}› Installing oh-my-zsh${normal}"
        echo

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

        echo
        printf "%40s\n" "${cyan}› Copying zsh configuration file${normal}"
        echo

        cp -f .zshrc ~/

        echo
        printf "%40s\n" "${cyan}› Installing zsh-syntax-highlighting plugin${normal}"
        echo

        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

        echo
        printf "%40s\n" "${cyan}› Verifying npm installation${normal}"
        echo

        if npm --help | grep -q 'doctor'; then
            printf "%40s\n" "${green}✔︎ npm successfully installed${normal}"
        fi

        echo
        printf "%40s\n" "${cyan}› Installing pure prompt${normal}"
        printf "%40s\n" "${cyan}› An error may occur during this installation, do not worry about it${normal}"
        echo

        npm install --global pure-prompt

        echo
        printf "%40s\n" "${cyan}› Copying npm configuration file & making a directory for packages${normal}"
        echo

        mkdir ~/.npm-packages
        cp -f .npmrc ~/
        
        echo
        printf "%40s\n" "${green}✔︎ Done!${normal}"
        echo
else
  echo '› Exiting';
fi