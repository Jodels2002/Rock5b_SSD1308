#!/bin/bash
# Install AmiRock
# B.Titze 2023.  # I2C2_SDA_M1, Install 1306 OLED Display
# https://github.com/rm-hull/luma.core

BLACK='\033[0;39m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
GREY='\033[1;30m'


   clear
      toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing  ... "


      sudo rm -rf /home/$USER/AmiRock/
      sudo rm -rf /opt/AmiRock/


   
      
      sudo cp -f -R ~/Rock5b_SSD1308/scripts/* /usr/local/bin
      sudo cp -f -R ~/Rock5b_SSD1308/ /opt
      sudo chmod -R 775 /usr/local/bin
      sudo chmod -R 775 /opt/Rock5b_SSD1308/



 clear 
if [ ! -d /opt/OLED/images/ ]; then

(crontab -l 2>/dev/null; echo "*/3 * * * * /usr/local/bin/loop.sh") | crontab -
  
  if [ ! -f /boot/armbianEnv.txt ]; then
  sudo echo "overlays=rk3588-i2c0-m1" >> /boot/armbianEnv.txt
  fi
  clear
fi
      clear
      toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing  ... "
      
      echo -e "$GREY " 
      sudo apt install -y python3-dev python3-pip libfreetype6-dev libjpeg-dev build-essential
      sudo apt install -y libsdl1.2-compat-dev  libportmidi-dev libsdl-ttf2.0-dev libsdl-mixer1.2-dev libsdl-image1.2-dev python3-dev
      clear
      toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing  Python ... "
       
        sudo python3 -m pip install -U setuptools
      clear
      toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing  Python ... "
        sudo python3 -m pip install -U gpiod
        clear
      toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing  Luma.Core ... "
        sudo pip install --upgrade luma.core
      clear
      toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing  Luma.Oled ... "
        sudo python3 -m pip install -U  luma.oled
        clear
      toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing  Psutil ... "
        sudo python3 -m pip install -U psutil
        
    clear
      toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing  Richard Hull´s Luma ... "
       
       cd
       
       git clone https://github.com/rm-hull/luma.examples.git
       sudo chmod -R 777 luma.examples
       cd luma.examples
       sudo -H pip install -e .
       
       
       mkdir /opt/OLED
       mkdir /opt/OLED/images

      
       
       cp -rf  ~/luma.examples/examples/fonts /opt/OLED/
       cp -rf  ~/luma.examples/examples/images /opt/OLED/
       cp -rf  ~/luma.examples/examples/hotspot /opt/OLED/
       cp -rf /opt/Rock5b_SSD1308/OLED/* /opt/OLED/
       sudo cp -rf /opt/OLED/fonts/* /usr/share/fonts/truetype/
       


if [  -d /home/rock/ ]; then
     sudo adduser rock i2c
fi

if [  -d /home/amiga/ ]; then
    sudo adduser amiga i2c
fi    
   sudo adduser root i2c
   
  sudo chmod -R 775 /usr/local/bin
  sudo chmod -R 775 /opt/Rock5b_SSD1308/
  sudo rm -rf ~/luma.examples 
  sudo rm -rf ~/Rock5b_SSD1308
    
  
  clear
      		toilet "AmiRock" --metal
      		echo " "
      		echo " luma.oled by Richard Hull"
        echo " "
sudo i2cdetect -y 0










