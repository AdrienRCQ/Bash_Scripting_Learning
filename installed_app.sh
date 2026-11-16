#!/bin/bash
# Linux installed application script

echo "### APT ###" > softwares.txt
apt-mark showmanual >> softwares.txt

echo -e "\n### SNAP ###" >> softwares.txt
snap list >> softwares.txt 2>/dev/null

echo -e "\n### FLATPAK ###" >> softwares.txt
flatpak list >> softwares.txt 2>/dev/null

cat softwares.txt