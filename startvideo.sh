#!/bin/bash
# Bash script by Tim Schwartz, http://www.timschwartz.org/raspberry-pi-video-looper/ 2013
# Comments, clean up, improvements by Derek DeMoss, for Dark Horse Comics, Inc. 2015

declare -A VIDS # make variable VIDS an Array

FILES=~/video/ # A variable of this folder
CURRENT=0 # Number of videos in the folder
SERVICE='omxplayer' # The program to play the videos
PLAYING=0 # Video that is currently playing

getvids () # Since I want this to run in a loop, it should be a function
{
unset VIDS # Empty the VIDS array
CURRENT=0 # Reinitializes the video count

for f in `ls $FILES | grep .mp` # Step through the file in ~/video/
do
	VIDS[$CURRENT]=$f # add the filename found above to the VIDS array
	let CURRENT+=1 # increment the video count
#	echo ${VIDS[$CURRENT]} # Print the array element we just added
done
}


while true; do
if ps ax | grep -v grep | grep $SERVICE > /dev/null # Search for service, print to null
then
	echo 'running'
else
	getvids # Get a list of the current videos in the folder
	let PLAYING+=1
	if [ $PLAYING -ge $CURRENT ] # if PLAYING is greater than or equal to CURRENT
	then
		PLAYING=0 # Reset to 0 so we play the "first" video
	fi

	/usr/bin/omxplayer -r -o hdmi $FILES${VIDS[$PLAYING]} # Play video 
#	echo "Array size= $CURRENT" # error checking code
fi
done



