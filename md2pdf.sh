#!/usr/bin/bash

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -s | --show )
    showflag=1
    echo "show!!"
  ;;
  -p | --slide ) # presentation 
    beamerflag=1
    echo "slide!!"
  ;;
esac; shift; done

if [[ "$1" == '--' ]]; then shift; fi

filename=$1
filenamewoext=$2
#pathame=$3

if [ -f $1 ]; then
 
  if [[ $beamerflag -eq 1 ]]; then 
    pandoc \
      -o $filenamewoext.pdf \
      --pdf-engine=xelatex \
      --verbose \
      -t beamer \
      -V mainfont="NanumGothic" \
      $filename
  else
    pandoc \
      -o $filenamewoext.pdf \
      --pdf-engine=xelatex \
      --verbose \
      -V mainfont="NanumGothic" \
      $filename 
  fi

  echo "showflag: "
  echo $showflag
  if [[ $showflag -eq 1 ]]; then
    xdotool search --onlyvisible --class chromium windowfocus key ctrl+r || \
      chromium --new-window $filenamewoext.pdf &
  fi

else
  echo "File does not exist."
fi
