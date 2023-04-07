#! /usr/bin/python3
# -*- coding: utf-8 -*-

import os
import sys
import time
import psutil
from pathlib import Path
from datetime import datetime
from luma.core.interface.serial import i2c
from luma.oled.device import sh1106, ssd1306
from PIL import ImageFont, ImageDraw
from luma.core.render import canvas
from PIL import ImageFont


serial = i2c(port=0, address=0x3C)
device = ssd1306(serial)

top = 0
width = 128
height = 64
device.height = 64
def bytes2human(n):
    """
    >>> bytes2human(10000)
    '9K'
    >>> bytes2human(100001221)
    '95M'
    """
    symbols = ('K', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y')
    prefix = {}
    for i, s in enumerate(symbols):
        prefix[s] = 1 << (i + 1) * 10
    for s in reversed(symbols):
        if n >= prefix[s]:
            value = int(float(n) / prefix[s])
            return '%s%s' % (value, s)
    return f"{n}B"


def cpu_usage():
    # load average, uptime
    uptime = datetime.now() - datetime.fromtimestamp(psutil.boot_time())
    av1, av2, av3 = os.getloadavg()
    return "   CPU:  %1.2f             %1f %1f   Up: %s" \
        % (av1, av2, av3, str(uptime).split('.')[0])


def mem_usage():
    usage = psutil.virtual_memory()
    return " RAM: %s %.0f%%" \
        % (bytes2human(usage.used), 100 - usage.percent)


def disk_usage(dir):
    usage = psutil.disk_usage(dir)
    return " HDD: %s %.0f%%" \
        % (bytes2human(usage.used), usage.percent)


def stats(device):
    # use custom font
    font1 = ImageFont.truetype('fontawesome-webfont.ttf', 19)
    font2 = ImageFont.truetype('C&C Red Alert [INET].ttf', 15)

 
    with canvas(device) as draw:
		 # Icon CPU
        draw.text((18, 3), cpu_usage(), font=font2, fill="white")
        draw.text((8, 0), chr(61444), font=font1, fill="white")
        if device.height >= 32:
			# Icon memory
            draw.text((28, 26), mem_usage(), font=font2, fill="white")
            draw.text((8, 22), chr(62171), font=font1, fill="white")
            # Icon disk
            draw.text((28, 48), disk_usage('/'), font=font2, fill="white")
            draw.text((8, 44), chr(61600), font=font1, fill="white")
        
            
        if device.height >= 128:
            draw.text((5, 34), disk_usage('/'), font=font2, fill="white")
          
        


def main():
    for x in range ( 25 ):
        stats(device)
        time.sleep(1)

if __name__ == "__main__":
    try:
    
        main()
    except KeyboardInterrupt:
        pass

