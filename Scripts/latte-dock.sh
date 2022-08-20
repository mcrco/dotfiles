if [ -z $(wmname | grep LG3D)]
then
	latte-dock --layout "kde" &
else
	latte-dock --layout "bspwm" &
fi
