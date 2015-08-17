#!/bin/bash

declare -A vids

FILES=~/video/
current=0
for f in `ls $FILES | grep .mp`
do
	vids[$current]=$f
	let current+=1
	echo ${vids[$current]}
done
max=$current
current=0
echo "max = $max"

SERVICE='omxplayer'
while true; do
if ps ax | grep -v grep | grep $SERVICE > /dev/null
then
echo 'running'
#sleep 1
else
let current+=1
if [ $current -ge $max ]
then
current=0
fi

#FILE=/home/pi/video/`ls /home/pi/video/ | head -n 1`
/usr/bin/omxplayer -r -o hdmi $FILES${vids[$current]}

fi
done





