#!/bin/bash

grep -Po '(?<=href=")[^"]*' ExampleLikedVideos.htm | grep -Po '^.*/video/[0-9]*$' > validLinks.txt

filename='validLinks.txt'
output_dir='output'

echo "Start"

# Check if the output directory exists, create it if not
if [ ! -d "$output_dir" ]; then
  mkdir "$output_dir"
  echo "Directory 'output' created."
else
  echo "Directory 'output' already exists."
fi

# Loop through each URL in the file and download to the output directory
while read -r p; do
  yt-dlp -o "$output_dir/%(title)s.%(ext)s" "$p"
done < "$filename"

rm validLinks.txt