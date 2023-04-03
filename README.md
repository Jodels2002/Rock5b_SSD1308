# Rock5b_SSD1308
OLED SSD1308 for the Radxa Rock5B

Prerequisite:

Tested on Armbian ( recommended) and Debian with user “rock”.

SSD 1306 i2C Oled Display 128*64

Pinout: https://wiki.radxa.com/Rock5/hardware/5b/gpio

GND=Pin9,
VCC=Pin1 (3.3V) or Pin3 (5V)
SCL=Pin28 (I2C0_SCL_M1)
SDA=Pin27 (I2C0_SDA_M1)



# Install Rock5b_SSD1308
Simply open a terminal in the installed Armibian and execute these lines:


sudo apt install git -y

cd

git clone --depth=1 https://github.com/Jodels2002/Rock5b_SSD1308.git

sudo chmod -R 775 Rock5b_SSD1308

cd Rock5b_SSD1308

./setup.sh





# Reboot and have fun 
   Greetings Bernd
