#!/bin/bash

# list finished leetcode problems
leetcode() {
	ls $HOME/dev/leetcode/
}

lists() {
	ls $HOME/.config/list
}

contents() {
	cat $HOME/.config/list/$1
}

add() {
	element=$1
	list=$2
	cp $HOME/.config/list/${list} $HOME/.config/list/.trash/${list}
	echo $element >> $HOME/.config/list/${list}
}

rm() {
	element=$1
	list=$2
	cp $HOME/.config/list/${list} $HOME/.config/list/.trash/${list}
	sed -i "/${element}/d" $HOME/.config/list/${list}
}

contains() {
	element=$1
	list=$2
	cat $HOME/.config/list/$list | grep $element
}

undo() {
	list=$1
	mv $HOME/.config/list/.trash/${list} $HOME/.config/list/${list}
}

"$@"
