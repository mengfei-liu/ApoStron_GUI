#/home/pi/install_ili210.sh
#/home/pi/install_sitronix.sh
#/home/pi/install_ft5406.sh
#/home/pi/ipInfo/saveIP&
#/home/pi/install_pm2203b.sh

#chown pi:pi: /home/pi/tsBootDebug.txt
chmod 777 /home/pi/tsBootDebug.txt

#TOUCHSCREEN AUTODETECT--------------START

# drive /RESET low, then high
gpio mode 34 out
gpio write 34 0
gpio write 34 1

sleep 2

gpio mode 32 ALT3
gpio mode 33 ALT3

sleep 2

#updated2

#start fresh boot debug file
echo "new" > /home/pi/tsBootDebug.txt

#check for ilitek touchscreen (usually at address 0x41)
if i2cget -y 3 0x41; then
       echo "installing ili210 touch" >> /home/pi/tsBootDebug.txt
       /home/pi/install_ili210.sh;

#check for ft5406 or pm22203b touchscreen (both usually at address 0x38)
elif i2cget -y 3 0x38; then

   returnVal="$(i2cdump -y 3 0x38 b | grep "a0: " | cut -d ' ' -f 5)"
   echo "$returnVal" >> /home/pi/tsBootDebug.txt
   if [ "$returnVal" = "0a" ]; then
#      echo "inside IF statement" >> /home/pi/bootDebug.txt
      returnVal2="$(i2cdump -y 3 0x38 b | grep "a0: " | cut -d ' ' -f 10)"
      echo "$returnVal2" >> /home/pi/tsBootDebug.txt
      if [ "$returnVal2" = "79" ]; then
         echo "installing ft5406 touch" >> /home/pi/tsBootDebug.txt
         /home/pi/install_ft5406.sh
      fi

   else
      echo "installing pm2203b touch" >> /home/pi/tsBootDebug.txt
      /home/pi/install_pm2203b.sh
   fi

#check for sitronix touchscreen (usually at address 0x55)
elif i2cget -y 3 0x55; then
       echo "installing st1633i touch" >> /home/pi/tsBootDebug.txt
       /home/pi/install_sitronix.sh;
else
       echo "no touchscreen detected" >> /home/pi/tsBootDebug.txt
fi
#TOUCHSCREEN AUTODETECT--------------END


if [ -e /boot/RUNDEMO.txt ]
then
   #Start basic EGL program
    export LD_LIBRARY_PATH=/usr/local/qt5pi/lib
   #/home/pi/qtlauncher > /dev/null 2>&1
    #/home/pi/qtlauncher
#export QT_QPA_EGLFS_NO_LIBINPUT=1
#export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS=rotate=270
#export QT_QPA_EGLFS_PHYSICAL_WIDTH=135
#export QT_QPA_EGLFS_PHYSICAL_HEIGHT=215
#export QML2_IMPORT_PATH=/data/user/qt/qmlplugins
#export QT_IM_MODULE=qtvirtualkeyboard
#export QT_QPA_EGLFS_FORCE888=1
#export QT_QUICK_CONTROLS_STYLE=Flat
#export XDG_RUNTIME_DIR=/tmp
#/home/pi/GUI_uart

#/home/pi/Adam_UI_v18
#/home/pi/Adam_UI_v19
#/home/pi/Adam_UI_v21_6
#/home/pi/Adam_UI_v23_logDtt
#/home/pi/Adam_UI_v23_1
else
   clear
   echo "Printing out ifconfig..."
   #ifconfig
   echo "\n\n To access the console, hold Alt + F1"
fi


#if [ -e /home/pi/updatefile.txt ]
#then
#	echo "File exists, remove file."
#	sudo chgrp pi /home/pi/updatefile.txt
#	sudo chown pi /home/pi/updatefile.txt
#	rm -f /home/pi/updatefile.txt
#	sync
#	#chmod 777 /home/pi/Adam_UI_New
#	#/home/pi/Adam_UI_New
#else
#	echo "File not exists, create file"
#	touch /home/pi/updatefile.txt
#	sync
#	#chmod 777 /home/pi/Adam_UI_Backup
#	#/home/pi/Adam_UI_Backup
#fi

if [ -e /home/pi/updatefile.txt ]
then
        echo "File exists, remove file."
        sudo chgrp pi /home/pi/updatefile.txt
        sudo chown pi /home/pi/updatefile.txt
        rm -f /home/pi/updatefile.txt
        chmod 777 /home/pi/Adam_UI_New
        sync
        /home/pi/Adam_UI_New
else
        touch /home/pi/updatefile.txt
        chmod 777 /home/pi/Adam_UI_Backup
        sync
        /home/pi/Adam_UI_Backup
fi
