---
layout: calendar_full
title: Calendar (Google)
description: Lecture, Discussion and OH schedules
nav_order: 3
---

# Calendar (Google)
Use this calendar if you want to integrate your class's Google Calendar into the website.

### Directions
1. In `_config.yml`: 
    1. Add your course's `google_calendar_id` (likely the course's Berkeley email)
    2. Create a `google_api_key`. This will involve creating a new [Google Cloud project](https://console.developers.google.com/) and following the directions [here](https://fullcalendar.io/docs/google-calendar).
    3. Update event types, along with their colors, under `event_types`.

{: .fs-4}
<a class="btn btn-blue" href="https://calendar.google.com/calendar?cid={{ site.google_calendar.google_calendar_id }}" target="_blank">Add to Google Calendar</a>


<!-- This page must include an element with a #full-calendar id -->
<div id="full-calendar" style="width: 100%"></div>