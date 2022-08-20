DIR=$HOME/.config/polybar/scripts

url=$($DIR/printFFTabs.sh | grep music.youtube.com)
#if grep -q $url $DIR/current-song; 
#then
#	exit 0
#fi
#echo $url > $DIR/current-song
rawtitle=$(wget -qO- "${url:14}" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)(?: - youtube)?\s*<\/title/si'o)
fixedtitle="${rawtitle/amp;/}"

if [[ ${#fixedtitle} -eq 0 ]]
then
	echo No Music Playing
fi

if [[ ${#fixedtitle} -gt 36 ]]
then
	truncatedtitle="${fixedtitle:0:33}..."
	echo $truncatedtitle
else 
	echo $fixedtitle
fi
