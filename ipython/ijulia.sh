#!/bin/sh
cd /mnt/tool && /usr/bin/ipython notebook --profile julia --pylab inline --port=7372 --ip=0.0.0.0 --script
