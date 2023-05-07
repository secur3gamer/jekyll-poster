#!/usr/bin/env bash

# Set variables
today=$(date +"%Y-%m-%d")
jekyllPath="/home/$USER/Documents/jekyll_blogs/cyklonsolutions_blog-testing"
jekyllPostPath="${jekyllPath}/_posts"

# User prompts
echo "Enter the title of the post:"
read jekyllPost

echo "If there's an image, type the file name (including extension, e.g. image.jpg). Otherwise, leave blank and press Enter:"
read bannerImage

echo "Type the category:"
read postCategory

echo "Type the tags (separated by spaces, multi-word tags separated by a hyphen):"
read postTags

echo "Type the body of the post:"
read blogPostContent

# Process input
blogFileName=$(echo -e "$today-$jekyllPost" | tr '[:upper:]' '[:lower:]' | tr '[:blank:]' - | tr -cd "[[:alnum:]-]")
bannerImageName=$(echo -e "$bannerImage" | tr -cd "[[:alnum:]_-].")
jekyllPostQuote=$(echo "\"$jekyllPost\"")
postTagsCommas=$(echo -e $postTags | tr '[:blank:]' , )

# Create the post
cat <<EOT >> "${jekyllPostPath}/${blogFileName}.md"
---
layout: post
title:  $jekyllPostQuote
date:   $today 09:00:00 +0200
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