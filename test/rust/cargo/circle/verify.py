#!/usr/bin/env python3

import math
import sys

with open(sys.argv[1]) as f:
    samples = f.read()

for line in samples.splitlines():
    xs, ys = line.split()
    x = int(xs)
    y = int(ys)
    radius = math.sqrt(x*x + y*y)
    print ("(%+3d,%+3d) -> %4.1f" % (x,y,radius))
    if radius > 100.0:
        sys.exit(1)
