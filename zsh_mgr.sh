#!/bin/sh
ligtGreen="\033[1;32m"
yellow="\033[1;33m"
endColor="\033[0m"

checkEnv()
{
    env="$(which ${1})"

    if [ -z "${env}" ]; then
        printf "${ligtGreen}Please install first${endColor} : ${yellow}${1}${endColor}\n"
        exit 1
    fi
}

installZshRC()
{
    rcFile=".zshrc"

    [ -f "${HOME}/${rcFile}" ] && mv "${HOME}/${rcFile}" "${HOME}/${rcFile}.bak"

    ln -s "$(pwd)/${rcFile}" "${HOME}/${rcFile}"
}

installOhMyZsh()
{
    ohMyZsh=".oh-my-zsh"

    [ -e "${HOME}/${ohMyZsh}" ] && mv "${HOME}/${ohMyZsh}" "${HOME}/${ohMyZsh}.bak"

    if [ ! -d "$(pwd)/${ohMyZsh}" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        mv "${HOME}/${ohMyZsh}" "$(pwd)/"
    fi

    ln -s "$(pwd)/${ohMyZsh}" "${HOME}/${ohMyZsh}"
}

installPowerLevel9kTheme()
{
    theme="$(pwd)/.oh-my-zsh/custom/themes/powerlevel9k"

    if [ ! -d "${theme}" ]; then
        git clone https://github.com/bhilburn/powerlevel9k.git "${theme}"
    fi
}

installZshHighLight()
{
    plugin="$(pwd)/.oh-my-zsh/plugins/zsh-syntax-highlighting"

    if [ ! -d "${plugin}" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${plugin}"
    fi
}

checkEnv "zsh"
checkEnv "curl"

installOhMyZsh
installZshRC
installPowerLevel9kTheme
installZshHighLight
