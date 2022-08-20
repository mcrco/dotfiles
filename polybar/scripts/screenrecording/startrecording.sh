#!/bin/bash

GPUstr=$(optimus-manager --print-mode)
currentGPU=${GPUstr:19}
	
cd $HOME/Videos/'Screen Recordings'

if [[ $currentGPU == "integrated" ]] 
then
	ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0+0,0 -f alsa -ac 2 -i hw:0 -b:v 3000K -b:a 160k -c:v libx264 "$(date +%Y_%m_%d_%I%M)".mkv &
else 
	ffmpeg -f x11grab -s 1920x1080 -r 60 -i :0.0 -f alsa -ac 1 -ac 2 \
		-i default -c:v h264_nvenc -s 1920x1080 \
		-ab 128k -ar 44100 \
		"$(date +%Y_%m_%d_%I%M)".mkv &
fi
