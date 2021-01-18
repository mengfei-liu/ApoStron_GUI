#!/bin/bash

/home/pi/hidecursor.sh

#/usr/bin/fbi -d /dev/fb0 -t 1 --once --noverbose /home/pi/logoSplash_800_foundry.png

#piping to /dev/null speeds up the 2nd read so the screen draw is fast
#/bin/cat /home/pi/logoSplash_800_foundry.bin > /dev/null
#/bin/cat /home/pi/logoSplash_800_foundry.bin > /dev/fb0


#this version is a little slower but the file is smaller
#/bin/gzip -dc /home/pi/logoSplash.bin.gz > /dev/null
#/bin/gzip -dc /home/pi/logoSplash.bin.gz > /dev/fb0

# drive the backlight high if it wasn't already configured by dt_blob.bin or the enableBL devicetree overlay
# without dt_blob or enableBL, the backlight will come on when the splash screen is shown
/usr/local/bin/gpio mode 40 out
/usr/local/bin/gpio write 40 1

#/home/pi/startup2.sh

#updated 1

exit 0

