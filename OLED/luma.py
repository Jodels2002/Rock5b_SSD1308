#! /usr/bin/python3
# -*- coding: utf-8 -*-
import sys
import math
from operator import itemgetter
from luma.core.interface.serial import i2c
from luma.core.sprite_system import framerate_regulator
from luma.core.render import canvas
from luma.oled.device import sh1106, ssd1306
from PIL import ImageFont, ImageDraw
import time

from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont
import subprocess



serial = i2c(port=0, address=0x3C)
device = sh1106(serial)

top = 0
width = 128
height = 64



oled_font = ImageFont.truetype('bodoni.ttf', 18)
with canvas(device) as draw:
    draw.rectangle(device.bounding_box, outline = "white", fill = "white")
    draw.text((10, 10), "Hallo Welt!", font = oled_font, fill = "black")
    draw.text((10, 30), "RockPi5", font = oled_font, fill = "black")

time.sleep(3)

with canvas(device) as draw:
    draw.rectangle(device.bounding_box, outline = "black", fill = "black")
    draw.text((10, 10), "Hallo Welt!", font = oled_font, fill = "white")
    draw.text((10, 30), "RockPi5", font = oled_font, fill = "white")

time.sleep(3)
def radians(degrees):
    return degrees * math.pi / 180


class point(object):

    def __init__(self, x, y, z):
        self.coords = (x, y, z)
        self.xy = (x, y)
        self.z = z

    def rotate_x(self, angle):
        x, y, z = self.coords
        rad = radians(angle)
        c = math.cos(rad)
        s = math.sin(rad)
        return point(x, y * c - z * s, y * s + z * c)

    def rotate_y(self, angle):
        x, y, z = self.coords
        rad = radians(angle)
        c = math.cos(rad)
        s = math.sin(rad)
        return point(z * s + x * c, y, z * c - x * s)

    def rotate_z(self, angle):
        x, y, z = self.coords
        rad = radians(angle)
        c = math.cos(rad)
        s = math.sin(rad)
        return point(x * c - y * s, x * s + y * c, z)

    def project(self, size, fov, viewer_distance):
        x, y, z = self.coords
        factor = fov / (viewer_distance + z)
        return point(x * factor + size[0] / 2, -y * factor + size[1] / 2, z)


def sine_wave(min, max, step=1):
    angle = 0
    diff = max - min
    diff2 = diff / 2
    offset = min + diff2
    while True:
        yield angle, offset + math.sin(radians(angle)) * diff2
        angle += step


def main(num_iterations=sys.maxsize):

    regulator = framerate_regulator(fps=30)

    vertices = [
        point(-1, 1, -1),
        point(1, 1, -1),
        point(1, -1, -1),
        point(-1, -1, -1),
        point(-1, 1, 1),
        point(1, 1, 1),
        point(1, -1, 1),
        point(-1, -1, 1)
    ]

    faces = [
        ((0, 1, 2, 3), "red"),
        ((1, 5, 6, 2), "green"),
        ((0, 4, 5, 1), "blue"),
        ((5, 4, 7, 6), "magenta"),
        ((4, 0, 3, 7), "yellow"),
        ((3, 2, 6, 7), "cyan")
    ]

    a, b, c = 0, 0, 0

    for angle, dist in sine_wave(8, 40, 1.5):
        with regulator:
            num_iterations -= 1
            if num_iterations == 0:
                break

            t = [v.rotate_x(a).rotate_y(b).rotate_z(c).project(device.size, 256, dist)
                for v in vertices]

            depth = []
            for idx, face in enumerate(faces):
                v1, v2, v3, v4 = face[0]
                avg_z = (t[v1].z + t[v2].z + t[v3].z + t[v4].z) / 4.0
                depth.append((idx, avg_z))

            with canvas(device, dither=True) as draw:
                for idx, depth in sorted(depth, key=itemgetter(1), reverse=True)[3:]:
                    (v1, v2, v3, v4), color = faces[idx]

                    if angle // 720 % 2 == 0:
                        fill, outline = color, color
                    else:
                        fill, outline = "black", "white"

                    draw.polygon(t[v1].xy + t[v2].xy + t[v3].xy + t[v4].xy, fill, outline)

            a += 0.3
            b -= 1.1
            c += 0.85
if __name__ == "__main__":
    try:
        
        main()
    except KeyboardInterrupt:
        pass
