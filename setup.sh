#!/bin/bash
# Install AmiRock
# B.Titze 2023


BLACK='\033[0;39m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
GREY='\033[1;30m'

  sudo apt install -y  toilet 
  clear
  toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing now ... "
      echo -e "$GREY " 
      sudo apt install -y dialog mc zip unzip wget 7zip
      
  ~/Rock5b_SSD1308/i2c.sh
