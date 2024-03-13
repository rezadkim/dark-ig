#!/data/data/com.termux/files/usr/bin/bash
echo -e "\n[wait] running pkg update and pkg upgrade (📦) ...\n"
pkg update -y && pkg upgrade -y
echo -e "\n[info] installing package and dependencies ...\n"
pkg install git which binutils python python-pip -y
echo -e "\n[info] cloning github repository -> 'dark-ig' ...\n"
git clone https://github.com/rezadkim/dark-ig && cd dark-ig
echo -e "\n[info] installing module and requirements ...\n"
pip install wheel && pip install -r requirements.txt
echo -e "\n[info] remove all README.md from data directories ...\n"
find data/ -name '*.md' -delete
echo -e "\n[done] running 'darkig.py' to open dark-ig console ...\n"
python3 darkig.py
