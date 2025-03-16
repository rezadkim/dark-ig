#!/usr/bin/bash

W="\033[0m"
R="\033[31m"
B="\033[34m"
G="\033[32m"
Y="\033[33m"

folder="dark-ig"

termux() {
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: running installer for Termux ..."
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: running update and upgrade package ..."
    echo
    pkg update -y
    pkg upgrade -y
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: installing ${Y}tur-repo${W} ..."
    echo
    pkg i -y tur-repo
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: installing ${Y}git${W}, ${Y}python3.10${W} ..."
    echo
    pkg i -y git python3.10 binutils build-essential libffi libjpeg-turbo libcrypt
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: cloning GitHub repository ..."
    echo
    if [ -d $folder ]; then
        mv $folder "${folder}-backup"
    fi
    git clone --depth 1 https://github.com/rezadkim/dark-ig
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: upgrading ${Y}pip${W} ..."
    echo
    python3.10 -m pip install --upgrade pip
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: install ${Y}requirements.txt${W} with pip ..."
    echo
    cd $folder || exit 1
    python3.10 -m pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: install ${Y}darkig${W} with setuptools ..."
    echo
    python3.10 -m pip install .
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: creating symbolic link for darkig ..."
    echo
    echo
    echo -e "${W}now you can run dark-ig with command: ${G}python darkig.py${W}"
}

linux() {
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: running installer for Linux ..."
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: adding package repository ${Y}ppa:deadsnakes/ppa${W} ..."
    echo
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt-get update -y
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: installing ${Y}git${W}, ${Y}python3.10${W} ..."
    echo
    sudo apt-get install git -y
    sudo apt-get install python3.10 python3.10-venv python3.10-distutils -y
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: cloning GitHub repository ..."
    echo
    if [ -d $folder ]; then
        mv $folder "${folder}-backup"
    fi
    git clone --depth 1 https://github.com/rezadkim/dark-ig
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: install ${Y}pip3.10${W} ..."
    echo
    curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python3.10
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: install ${Y}requirements.txt${W} with pip3.10 ..."
    echo
    cd $folder || exit 1
    python3.10 -m pip install -r requirements.txt
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: install ${Y}darkig${W} with setuptools ..."
    echo
    python3.10 -m pip install .
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: creating symbolic link for darkig ..."
    echo
    # Buat symlink ke darkig.py di direktori yang ada di PATH
    sudo ln -sf "$(pwd)/darkig.py" /usr/local/bin/darkig
    echo
    echo -e "${W}[ ${B}INFO${W} ] ${G}dark-ig${W}: cleaning cache after build ${Y}setup.py${W} ..."
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
        echo -e "${W}now you can run dark-ig with command: ${G}darkig${W}"
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
