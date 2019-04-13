#!/usr/bin/env bash

# Colors
green=$(tput setaf 2)
cyan=$(tput setaf 6)
normal=$(tput sgr0)

# Welcome message
echo "Welcome! Before you start, please make sure that:"
echo "- You are using Linux Mint (this script might also work on Ubuntu, but it has not been tested there)"
echo "- You checked the configuration files and adjusted them to your needs"
echo

# Simple prompt
read -p "Ready to start? (y/n)? " CONT
if [ "$CONT" = 'y' ]; then
        printf "%40s\n" "${cyan}› Installing necessary packages...${normal}"

        sudo apt-get update > /dev/null 2>&1
        sudo apt install zsh curl nodejs npm git > /dev/null 2>&1

        printf "%40s\n" "${cyan}› Verifying zsh installation...${normal}"


        if zsh --version | grep -q 'zsh'; then
            printf "%40s\n" "${green}✔︎ zsh successfully installed${normal}"
        fi

        printf "%40s\n" "${cyan}› Making zsh a default shell...${normal}"

        chsh -s $(which zsh)

        printf "%40s\n" "${cyan}› Checking if zsh is a default shell...${normal}"

        if echo $SHELL | grep -q 'zsh'; then
            printf "%40s\n" "${green}✔ ︎zsh is now a default shell${normal}"
        fi

        printf "%40s\n" "${cyan}› Installing oh-my-zsh...${normal}"

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null 2>&1

        printf "%40s\n" "${cyan}› Copying zsh configuration file...${normal}"

        cp -f .zshrc ~/ > /dev/null 2>&1

        printf "%40s\n" "${cyan}› Checking if zsh configuration file was copied...${normal}"

        if [ -e "~/.zshrc" ]; then
            printf "%40s\n" "${green}✔ ︎zsh configuration was copied successfully${normal}"
        fi 

        printf "%40s\n" "${cyan}› Installing zsh-syntax-highlighting plugin...${normal}"

        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting > /dev/null 2>&1

        printf "%40s\n" "${cyan}› Verifying npm installation...${normal}"

        if npm --help | grep -q 'doctor'; then
            printf "%40s\n" "${green}✔︎ npm successfully installed${normal}"
        fi

        printf "%40s\n" "${cyan}› Installing pure prompt...${normal}"

        npm install --global pure-prompt > /dev/null 2>&1

        printf "%40s\n" "${cyan}› Copying npm configuration file & making a directory for packages...${normal}"

        mkdir ~/.npm-packages > /dev/null 2>&1
        cp -f .npmrc ~/ > /dev/null 2>&1

        printf "%40s\n" "${cyan}› Checking if npm configuration file was copied...${normal}"

        if [ -e "~/.npmrc" ]; then
            printf "%40s\n" "${green}✔ ︎zsh configuration was copied successfully${normal}"
        fi 
        
        printf "%40s\n" "${green}✔︎ Done!${normal}"
else
  echo "› Exiting";
fi