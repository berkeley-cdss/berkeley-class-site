---
layout: calendar_dynamic
title: Calendar (Dynamic)
description: Lecture, Discussion and OH schedules
nav_order: 3
---

# Calendar (Dynamic)
Use this calendar if you want to integrate your class's Google Calendar into the website.

## Directions
1. In `_config.yml`: 
    1. Add your course's `google_calendar_id` (likely the course's Berkeley email)
    2. Create a `google_api_key`. This will involve creating a new [Google Cloud project](https://console.developers.google.com/) and following the directions [here](https://fullcalendar.io/docs/google-calendar).
    3. View event types, along with their colors and icons, under `event_types`. Your Google Calendar titles should have the appropriate prefix or suffix matching these event types. For example, if your calendar event title is "[Data 101] Lecture", `_config.yml` should have `suffix: Lecture`. If instead, your calendar event title is "Lecture - Pivots and Joins", `_config.yml` should have `prefix: Lecture`. We recommend only changing `suffix` / `prefix` and none of the other fields.

{: .fs-4}
<a class="btn btn-blue" href="https://calendar.google.com/calendar?cid={{ site.google_calendar.google_calendar_id }}" target="_blank">Add to Google Calendar</a>


<!-- This page must include an element with a #full-calendar id -->
<div id="full-calendar" style="width: 100%"></div>