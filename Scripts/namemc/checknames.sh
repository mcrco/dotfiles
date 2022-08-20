#!/bin/bash
cat /home/mod3sty/Scripts/namemc/words | \
	while read -r a; 
	do  
		if [[ -z $(curl "https://namemc.com/search?q=$a" | grep "Unavailable") ]] 
		then 
			echo $a >> ./available
		fi
		sleep 0.5
	done
