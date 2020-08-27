#!/bin/#!/usr/bin/env bash

# 1970-01-01
today=$(date +"%Y-%m-%d")
jekyllPath="/home/$USER/Documents/jekyll_blogs/cyklonsolutions_blog-testing"
jekyllPostPath="/home/$USER/Documents/jekyll_blogs/cyklonsolutions_blog-testing/_posts"
# Below are the user prompts
echo "Enter the title of the post"
read jekyllPost

echo "If there's an image, type the file name (including extension, e.g. image.jpg)"
echo "If there is no banner image please leave blank and press Enter"
read bannerImage

echo "Type the category"
read postCategory

echo "Type the tags (separated by spaces, multi-word tags separated by a hyphen)"
read postTags

echo "Type the body of the post"
read blogPostContent
# End user prompts

blogFileNameSpaces="$today-$jekyllPost"
blogFileName=$(echo -e "$blogFileNameSpaces" | tr '[:upper:]' [:lower:] | tr '[:blank:]' - | tr -cd "[[:alnum:]-]")
bannerImageName=$(echo -e "$bannerImage" | tr -cd "[[[[:alnum:]-]_].]")
jekyllPostQuote=$(echo '"'$jekyllPost'"')
postTagsCommas=$(echo -e $postTags | tr '[:blank:]' , )

echo "---
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

" >> $jekyllPostPath/"$blogFileName".md

echo "Make final edits to the post '$blogFileName.md' and then press Enter to build"
read -n 1 -s -r -p "Press any key to continue"

cd $jekyllPath && bundle exec jekyll build
