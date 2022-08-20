#!/bin/bash

#function to go to AOPS for problem (p) on the AMC (level) (version)

answer() {
	year=$1
	levelversion=$2
	problem=$3
	
	echo "$year"
	echo "$levelversion"

	/usr/bin/firefox "https://artofproblemsolving.com/wiki/index.php/${year}_AMC_${levelversion^^}_Problems/Problem_${problem}"
}

