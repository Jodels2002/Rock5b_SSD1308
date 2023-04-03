#!/bin/bash
# Install AmiRock
# B.Titze 2023.  # I2C2_SDA_M1, Install 1306 OLED Display
# https://github.com/rm-hull/luma.core

BLACK='\033[0;39m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
GREY='\033[1;30m'

   sudo apt update -y
   sudp apt upgrade -y
 if [  -f /boot/config.txt  ]; then  
   export DISTRO=focal-stable
   wget -O - apt.radxa.com/$DISTRO/public.key | sudo apt-key add -
   sudo apt-get dist-upgrade -y
   isInFile=$(cat /boot/config.txt  | grep -c "dtoverlay=rk3588-i2c0-m1")
   if [ $isInFile -eq 0 ]; then 
    sudo apt install -y cron
    sudo cp -rf /boot/config.txt  /home/
    sudo chmod -R 777 /home/config.txt 
    sudo echo "dtoverlay=rk3588-i2c0-m1" >> /home/config.txt 
    sudo rm /boot/config.txt
    sudo cp -rf /home/config.txt   /boot/
    #sudo rm /home/config.txt 
    echo "dtoverlay=rk3588-i2c0-m1 added to config.txt "
   else
 echo "dtoverlay=rk3588-i2c0-m1 found in config.txt :-) "
   fi
fi


 if [  -f /boot/armbianEnv.txt  ]; then 
      isInFile=$(cat /boot/armbianEnv.txt  | grep -c "overlays=rk3588-i2c0-m1")
   if [ $isInFile -eq 0 ]; then 
    sudo apt install -y cron
    sudo cp -rf /boot/armbianEnv.txt  /home/
    sudo chmod -R 777 /home/armbianEnv.txt 
    sudo echo "overlays=rk3588-i2c0-m1" >> /home/armbianEnv.txt
    sudo rm /boot/config.txt
    sudo cp -rf /home/armbianEnv.txt   /boot/
    #sudo rm /home/armbianEnv.txt
    echo "overlays=rk3588-i2c0-m1 added to config.txt "
   else
 echo "overlays=rk3588-i2c0-m1 found in config.txt :-) "
   fi
     fi


   clear
      toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing  ... "
    
    if [ ! -d /opt/OLED/images/ ]; then 
     sudo rm -rf /opt/OLED
     sudo  mkdir /opt/OLED
     sudo   mkdir /opt/OLED/images
     sudo   mkdir /opt/OLED/fonts

    fi

     
      
      sudo cp -f -R ~/Rock5b_SSD1308/scripts/* /usr/local/bin
      sudo cp -f -R ~/Rock5b_SSD1308/ /opt
      sudo chmod -R 775 /usr/local/bin
      sudo chmod -R 775 /opt/



 clear 
if [ ! -f /opt/OLED/images/banana.gif ]; then

(crontab -l 2>/dev/null; echo "*/3 * * * * /usr/local/bin/loop.sh") | crontab -
  

  clear
fi

  
      clear
      toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing  ... "
      
      echo -e "$GREY " 
      sudo apt install -y python3-dev python3-pip 
      sudo apt install -y libfreetype6-dev libjpeg-dev build-essential
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
        
    


if [  -d /home/rock/ ]; then
     sudo adduser rock i2c
fi

if [  -d /home/amiga/ ]; then
    sudo adduser amiga i2c
    # echo 'amiga ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers
fi    
   sudo adduser root i2c


       if [ ! -f /opt/OLED/fonts/code1000.ttf ]; then 
          clear
      toilet "Rock5b OLED" --metal
      echo " "
      echo -e "$BLUE "
      echo "installing  Richard Hull´s Luma ... "
      echo -e "$GREY "
       
       cd
       
       git clone https://github.com/rm-hull/luma.examples.git
       sudo chmod -R 777 luma.examples
       cd luma.examples
       sudo -H pip install -e .
     
       
       sudo cp -rf  ~/luma.examples/examples/fonts /opt/OLED/
       sudo cp -rf  ~/luma.examples/examples/images /opt/OLED/
       sudo cp -rf  ~/luma.examples/examples/hotspot /opt/OLED/
       sudo cp -rf /opt/Rock5b_SSD1308/OLED/* /opt/OLED/
       sudo cp -rf /opt/OLED/fonts/* /usr/share/fonts/truetype/
    fi
   
  sudo chmod -R 775 /usr/local/bin
  sudo chmod -R 775 /opt/
  
  sudo rm -rf ~/Rock5b_SSD1308
  sudo rm -rf ~/luma.examples
    
  
  clear
      		toilet "luma.oled" --metal
      		echo " "
      		echo " luma.oled by Richard Hull"
            echo " "
            echo -e "$GREY Rock5b port by Jodels2002"
            echo -e "$GREY https://github.com/Jodels2002/Rock5b_SSD1308 "
        
        echo -e "$BLUE "
        echo " "
echo -e "$BLUE "       
sudo i2cdetect -y 0
echo -e "$GREY "

  








