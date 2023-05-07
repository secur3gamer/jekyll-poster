#!/usr/bin/env bash

# Save the current terminal settings
saved_stty=$(stty -g)

# Set the erase character to the backspace character
stty erase '^H'

# Restore the saved terminal settings when the script exits
trap 'stty "$saved_stty"' EXIT

# Function to get Jekyll path
get_jekyllPath() {
  read -p "Enter the path of your Jekyll blog (leave blank for default path): " input_jekyllPath
  if [ -z "$input_jekyllPath" ]; then
    echo $default_jekyllPath
  else
    echo $input_jekyllPath
  fi
}

# Set default Jekyll path and get the path from the user
default_jekyllPath="/home/$USER/code/jekyll/jekyllpostertest"
jekyllPath=$(get_jekyllPath)
jekyllPostPath="${jekyllPath}/_posts"
echo "Jekyll Path: $jekyllPath"
echo "Jekyll Post Path: $jekyllPostPath"

# User prompts
read -p "Enter the title of the post: " jekyllPost
read -p "If there's an image, type the file name (including extension, e.g. image.jpg). Otherwise, leave blank and press Enter: " bannerImage
read -p "Type the category: " postCategory
read -p "Type the tags (separated by spaces, multi-word tags separated by a hyphen): " postTags
read -p "Choose between post for today or a future post (type 'today' or 'future'): " postDateChoice

if [ "$postDateChoice" == "today" ]; then
  post_date=$(date +"%Y-%m-%d")
else
  read -p "Enter the date for the future post (YYYY-MM-DD): " post_date
fi

read -p "Enter the time zone (e.g. +0200): " timeZone

echo -e "Type the body of the post (use any markdown formatting):\nTo finish the post body, type 'EOF' on a new line and press Enter."
blogPostContent=""
while true; do
  read -r line
  if [[ "$line" == "EOF" ]]; then
    break
  fi
  blogPostContent+="$line"$'\n'
done

# Process input
blogFileName=$(echo -e "$post_date-$jekyllPost" | tr '[:upper:]' '[:lower:]' | tr '[:blank:]' - | tr -cd "[[:alnum:]-]")
bannerImageName=$(echo -e "$bannerImage" | tr -cd "[:alnum:]_.-")
jekyllPostQuote=$(echo "\"$jekyllPost\"")
postTagsCommas=$(echo -e $postTags | tr '[:blank:]' , )

# Create the post
cat <<EOT >> "${jekyllPostPath}/${blogFileName}.md"
---
layout: post
title:  $jekyllPostQuote
date:   $post_date 09:00:00 $timeZone
banner_image: "$bannerImageName"
categories: "$postCategory"
tags: ["$postTagsCommas"]
---

$blogPostContent

<hr />

<small>Post created with [Jekyll Poster](https://github.com/secur3gamer/jekyll-poster)</small>
EOT

# Build the site
echo "Make final edits to the post '${blogFileName}.md' and then press Enter to build"
read -p "Press any key to continue" -n 1 -r -s
cd $jekyllPath && bundle exec jekyll build
