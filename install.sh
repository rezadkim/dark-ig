#!/usr/bin/bash

W="\033[0m"
R="\033[31m"
B="\033[34m"
G="\033[32m"
Y="\033[33m"

folder="rezadkim"

termux() {
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: running installer for termux ..."
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: running update and upgrade package ..."
    echo
    pkg update -y
    pkg upgrade -y
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: installing ${Y}tur-repo${W} ..."
    echo
    pkg i -y tur-repo
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: installing ${Y}git${W}, ${Y}python3.10${W} ..."
    echo
    pkg i -y git python3.10 binutils build-essential
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: cloning github repository ..."
    echo
    if [ -d $folder ]; then
        mv $folder "${folder}-backup"
    fi
    git clone --depth 1 https://github.com/rezadkim/dark-ig
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: upgrading ${Y}pip3.10${W} ..."
    echo
    python3.10 -m pip install --upgrade pip
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: install ${Y}requirements.txt${W} with pip3.10 ..."
    echo
    cd $folder || exit 1
    python3.10 -m pip install -r requirements.txt
    echo
    echo
    python3.10 -m pip install .
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: cleaning cache after build ${Y}setup.py${W} ..."
    [ -d build ] && rm -rf build
    [ -d darkig.egg-info ] && rm -rf darkig.egg-info
    find . -name "*.jpg" -delete
    find . -name "*.png" -delete
    find . -name "*.md" -delete
    echo
    if [ -f /data/data/com.termux/files/usr/bin/darkig ]; then
        echo -e "${G}INSTALLATION SUCCESS${W}"
        echo
        python3.10 -m pip show darkig
        echo
        echo -e "${W}now you can run darkig with command: ${G}darkig${W}"
        echo
    else
        echo -e "${R}INSTALLATION FAILED${W}"
        echo
    fi
}

linux() {
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: running installer for linux ..."
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: adding package repository ${Y}ppa:savoury1/python${W} ..."
    echo
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt-get update
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: installing ${Y}git${W}, ${Y}python3.10${W} ..."
    echo
    sudo apt-get install git -y
    sudo apt-get install python3.10 python3.10-venv python3.10-distutils -y
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: cloning github repository ..."
    echo
    if [ -d $folder ]; then
        mv $folder "${folder}-backup"
    fi
    git clone --depth 1 https://github.com/iqbalmh18/darkig
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: install ${Y}pip3.10${W} ..."
    echo
    curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python3.10
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: install ${Y}requirements.txt${W} with pip3.10 ..."
    echo
    cd $folder || exit 1
    python3.10 -m pip install -r requirements.txt
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: install ${Y}darkig${W} with setuptools ..."
    echo
    python3.10 -m pip install .
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}darkig${W}: cleaning cache after build ${Y}setup.py${W} ..."
    [ -d build ] && rm -rf build
    [ -d darkig.egg-info ] && rm -rf darkig.egg-info
    find . -name "*.jpg" -delete
    find . -name "*.png" -delete
    find . -name "*.md" -delete
    echo
    if command -v darkig &> /dev/null; then
        echo -e "${G}INSTALLATION SUCCESS${W}"
        echo
        python3.10 -m pip show darkig
        echo
        echo -e "${W}now you can run darkig with command: ${G}darkig${W}"
        echo
    else
        echo -e "${R}INSTALLATION FAILED${W}"
        echo
    fi
}

if command -v termux-change-repo &> /dev/null; then
    termux
else
    linux
fi
