import sys
import math
import random
import time
import datetime
from pathlib import Path
from operator import itemgetter
from luma.core.interface.serial import i2c
from luma.core.sprite_system import framerate_regulator
from luma.core.render import canvas
from luma.oled.device import sh1106, ssd1306
from PIL import Image, ImageSequence, ImageDraw, ImageFont  

import subprocess



serial = i2c(port=0, address=0x3C)
device = sh1106(serial)

top = 0
width = 128
height = 64

def primitives(device, draw):
    # Draw some shapes.
    # First define some constants to allow easy resizing of shapes.
    padding = 2
    shape_width = 20
    top = padding
    bottom = device.height - padding - 1
    # Move left to right keeping track of the current x position for drawing shapes.
    x = padding
    # Draw an ellipse.
    draw.ellipse((x, top, x + shape_width, bottom), outline="red", fill="black")
    x += shape_width + padding
    # Draw a rectangle.
    draw.rectangle((x, top, x + shape_width, bottom), outline="blue", fill="black")
    x += shape_width + padding
    # Draw a triangle.
    draw.polygon([(x, bottom), (x + shape_width / 2, top), (x + shape_width, bottom)], outline="green", fill="black")
    x += shape_width + padding
    # Draw an X.
    draw.line((x, bottom, x + shape_width, top), fill="yellow")
    draw.line((x, top, x + shape_width, bottom), fill="yellow")
    x += shape_width + padding
  # Write two lines of text.
    size = draw.textsize('World!')
    x = device.width - padding - size[0]
    draw.rectangle((x, top + 4, x + size[0], top + size[1]), fill="black")
    draw.rectangle((x, top + 16, x + size[0], top + 16 + size[1]), fill="black")
    draw.text((device.width - padding - size[0], top + 10), 'Hello', fill="cyan")
    draw.text((device.width - padding - size[0], top + 26), 'Radxa!', fill="purple")
    # Draw a rectangle of the same size of screen
    draw.rectangle(device.bounding_box, outline="white")


def main():
   

    print("Testing basic canvas graphics...")
    for _ in range(2):
        with canvas(device) as draw:
            primitives(device, draw)
    time.sleep(5)

    print("Testing contrast (dim/bright cycles)...")
    for _ in range(5):
        for level in range(255, -1, -10):
            device.contrast(level)
            time.sleep(0.1)
        time.sleep(0.5)

        for level in range(0, 255, 10):
            device.contrast(level)
            time.sleep(0.1)

        time.sleep(1)

    print("Testing display ON/OFF...")
    for _ in range(5):
        time.sleep(0.5)
        device.hide()

        time.sleep(0.5)
        device.show()

    print("Testing clear display...")
    time.sleep(2)
    device.clear()

    print("Testing screen updates...")
    time.sleep(2)
    for x in range(40):
        with canvas(device) as draw:
            now = datetime.datetime.now()
            draw.text((x, 4), str(now.date()), fill="white")
            draw.text((10, 16), str(now.time()), fill="white")
            time.sleep(0.1)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        pass
