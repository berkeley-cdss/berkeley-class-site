---
title: Calendar Documentation
permalink: /docs/calendar-documentation/
published: true
layout: page
parent: Documentation
nav_order: 5
---

# Calendar Documentation
We currently have two implementations for the course calendar: One is a static version that won't change week to week, while the other is a dynamic version that uses a Google Calendar integration to display events. This page describes how to edit and update the Google Calendar version.

## Set-Up
To set up the calendar for the first time, we'll need to install npm and get the fullcalendar package, which is used as the template for the dynamic calendar. Run the following commands:

1. Install npm (on Mac, can run `brew install node`)
2. Run `npm init`
3. Download/update the fullcalendar packages and its associated plugins (run this command to update the current files).
```bash
    npm install --save \               
        @fullcalendar/core \ 
        @fullcalendar/web-component \ 
        @fullcalendar/timegrid \ 
        @fullcalendar/icalendar \ 
        fullcalendar
```
4. When we want to move the updated packages to the website, we can run `npm install`, which uses the script below to move the relevant files from `./node_modules/` (not pushed, only for developers) to `./assets/vendor/` (pushed, accessible to all classess).
```json
"scripts": {
    "postinstall": "cp -r ./node_modules/fullcalendar/ ./assets/vendor/fullcalendar/dist && cp -r ./node_modules/@fullcalendar/ ./assets/vendor/fullcalendar/packages"
  }
```
Most of the installed files will not need to be touched. The ones most relevant to classes will be:
- `_config.yml`: For setting up the calendar with the course's specifications.
- `full-calendar.html`: Retrieves the html for the calendar (shouldn't need to touch).
- `calendar_dynamic.md`: Student-facing page for the dynamic calendar.
- `fullcalendar.js`: The **staff-generated JavaScript file** for the dynamic calendar. If you want to make any changes to how the calendar is generated or need to debug, you'll likely want to start here.