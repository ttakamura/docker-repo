#!/bin/sh
cd /mnt/tool && /usr/bin/ipython notebook --pylab inline --port=7373 --ip=0.0.0.0 --script
