#!/bin/bash
filename=$1
cp /home/mod3sty/.local/share/leetcode.java $HOME/dev/leetcode/${filename}.java
sed -i "s/filename/${filename}/g" $HOME/dev/leetcode/${filename}.java
nvim ${filename}.java
