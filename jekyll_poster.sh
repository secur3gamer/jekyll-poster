#!/bin/#!/usr/bin/env bash

today=$(date +"%Y-%m-%d")

echo "Enter the title of the post"
read jekyllPost

echo "Is there a banner image? If so type the file name (including extension, e.g. .jpg)"
read bannerImage

echo "Type the category"
read postCategory

echo "Type the tags (separated by spaces, multi-word tags separated by a hyphen)"
read postTags

echo "Type the body of the post"
read blogPostContent

blogFileNameSpaces="$today-$jekyllPost"
blogFileName=$(echo -e "$blogFileNameSpaces" | tr '[:upper:]' [:lower:] | tr '[:blank:]' - | tr -cd "[[:alnum:]-]")
bannerImageName=$(echo -e "$bannerImage" | tr -cd "[[[[:alnum:]-]_].]")

echo "---
layout: post
title:  "$jekyllPost"
date:   "$today 09:00:00 +0200"
banner_image: "$bannerImageName"
categories: "$postCategory"
tags: ["$postTags"]
---

$blogPostContent

<hr />

{% include end_blurb.html %}

" >> /home/mang/Documents/bash/"$blogFileName".md
