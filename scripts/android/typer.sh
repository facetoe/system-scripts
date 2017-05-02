#!/usr/bin/env bash

# Script for typing on my broken Android. 

X=450
Y=400
while true ; do
  while read -r INPUT; do
	adb shell input text $(printf "%q" "${INPUT}" | sed -e 's/ /%s/g') && adb shell input tap $X $Y
  done
done
