#!/bin/bash

root="/home/user/web/dir/"
filename="mikro"
cssURL="style.css"

function gen {
  pandoc -c $cssURL -s -H ${root}html_header.html --webtex "${root}header.md" "${root}${filename}.md" -o "${root}${filename}.html"
}

function openEditor {
  vim "${root}${filename}.md"
}

if [ "$#" -ge 1 ]; then
  if [ "$1" = "gen" ]; then
    gen
    exit
  fi
  if [ "$1" = "edit" ]; then
    openEditor
    exit
  fi
fi

content=$(cat)
datetime=$(date +"%d.%m.%y - %R")

echo "### $datetime

$content

" >> "${root}mikro_new.md"
mv "${root}${filename}.md" "${root}${filename}_old.md"
cat "${root}mikro_new.md" "${root}${filename}_old.md" > "${root}${filename}.md"

gen

rm "${root}mikro_"*
