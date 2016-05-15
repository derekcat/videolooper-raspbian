#Video Looper for Raspbian
Automatically play and loop full screen videos on a Raspberry Pi 2 or 3.
Original by [Tim Schwartz](http://www.timschwartz.org/raspberry-pi-video-looper/)

This system uses a basic bash script to play videos with [omxplayer](http://elinux.org/Omxplayer), it simply checks if omxplayer isn't running and then starts it again. This simple method seems to work flawlessly for weeks on end without freezing or glitches. The only caveat of this method is that there are approximately 2-3 seconds of black between each video. If you are looking to do something with gapless looping on Raspberry Pi, try [Slooper](https://github.com/mokafolio/Slooper) by [Matthias Dörfelt](http://www.mokafolio.de/), though currently it needs a few updates to work without a remote (as of May 15, 2016).

There is a [videolooper](https://github.com/adafruit/pi_video_looper) written in python that uses omxplayer by [Adafruit](http://www.adafruit.com), but unfortunately on testing looping videos for more than a day it froze (as of May 15, 2016).

The script will look for videos either in:
* the `video` directory in the home directory of the pi user
* a usb stick plugged in before startup (this will not be remounted if you pull it out and plug it back in)

There are two methods of installation, either:
* Grab your own [raspbian img](https://www.raspberrypi.org/downloads/raspbian/), install it on the pi, and follow the steps below to install the videolooper.
* Copy the prebuilt img that has already been setup using the steps below (`2016-05-10-raspbian-jessie-lite` was used as the base image).

##Script Installation

###Install omxplayer
```sudo apt-get update
sudo apt-get -y install omxplayer
```

###Setup auto mounting of usb stick
```sudo mkdir -p /mnt/usbdisk
sudo echo \"/dev/sda1	/mnt/usbdisk	vfat	ro,defaults	0	0\" | sudo tee -a /etc/fstab
sudo mount /mnt/usbdisk
```

###Create folder for videos in home directory
`mkdir /home/pi/video`

###Download startvideo.sh and put it in /home/pi/
```wget https://raw.githubusercontent.com/derekcat/videolooper-raspbian/master/startvideo.sh'
chmod uga+rwx startvideo.sh
```

###Add startvideo.sh to .bashrc so it auto starts on login
`echo \"/home/pi/startvideo.sh" | tee -a /home/pi/.bashrc`

###Make system autoboot into pi user
`sudo raspi-config`
* Select option: "3 Boot Options"
* Select option: "B2 Console Autologin"

###Expand your root partition if you want to
`sudo raspi-config`
* Select option: "1 Expand Filesystem"

