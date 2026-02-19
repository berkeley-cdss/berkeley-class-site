---
layout: page
title: Announcements
nav_exclude: true
description: A feed containing all of the class announcements.
---

# Announcements

Announcements are stored in the `_announcements` directory and rendered according to the layout file, `_layouts/announcement.html`.

Here's a few different ways to display announcements:

## Announcement Carousel 

{% include announcement-navigation.html %}

## The most recent announcement

{% assign announcement = site.announcements | last %}
{{ announcement }}

## All announcements, with the most recent first

{% assign announcements = site.announcements | reverse %}
{% for announcement in announcements %}
{{ announcement }}
{% endfor %}
