#!/usr/bin/env bash

# Colors
green=$(tput setaf 2)
cyan=$(tput setaf 6)
normal=$(tput sgr0)

# Welcome message
echo
cat << "EOF"
|  _  \    | |      
| | | |___ | |_ ___ 
| | | / _ \| __/ __|
| |/ / (_) | |_\__ \
|___/ \___/ \__|___/  
EOF
echo
echo "Welcome!"
echo "This script will install xxczaki's dotfiles on your machine"
echo "More information here: https://github.com/xxczaki/dots"
echo

# Simple prompt
read -p "Ready to start? (y/n)? " CONT
if [ "$CONT" = 'y' ]; then
        echo
        printf "${cyan}› Warming up...${normal}"
        echo

        sudo apt update -y > /dev/null 2>&1
        sudo apt install -y zsh curl git > /dev/null 2>&1

        curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - > /dev/null 2>&1

        echo
        printf "${cyan}› Configuring zsh${normal}"
        echo

        printf "${cyan} › Making zsh a default shell...${normal}"

        chsh -s $(which zsh)
        echo

        printf "${cyan} › Copying zsh configuration file...${normal}"

        cp -f assets/.zshrc ~/ > /dev/null 2>&1
        echo

        printf "${cyan} › Installing oh-my-zsh...${normal}"

        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null 2>&1
        echo

        printf "${cyan} › Installing zsh-syntax-highlighting plugin...${normal}"

        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting > /dev/null 2>&1
        echo

        printf "${cyan} › Installing pure prompt...${normal}"

        npm install --global pure-prompt > /dev/null 2>&1
        echo

        printf "${green}✔︎ Finished zsh configuration!${normal}"
        echo

        echo
        printf "${cyan}› Configuring Node.js environment...${normal}"
        echo

        printf "${cyan} › Installing Node.js & npm...${normal}"

        sudo apt install -y nodejs > /dev/null 2>&1
        echo

        printf "${cyan} › Making a directory for packages...${normal}"

        mkdir ~/.npm-packages > /dev/null 2>&1
        echo

        printf "${cyan} › Copying npm configuration file${normal}"

        cp -f assets/.npmrc ~/ > /dev/null 2>&1
        echo
        
        printf "${green}✔︎ Done!${normal}"
        echo
else
  echo "› Exiting";
fi
