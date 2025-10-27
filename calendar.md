---
layout: page 
title: Calendar (Static)
description: Lecture, Discussion and OH schedules
nav_order: 2
---

# Calendar (Static)
Use this calendar if you want a static version for your class. This works better if your class's schedule doesn't change from week to week and if you don't want to maintain a Google Calendar.

## Directions
To add events, go to `weekly.md` and include the name, start/end times, and location.

To change colors of events, go to `schedule.scss` and look for the class `.schedule-event` followed by the name of the event (e.g. "Lecture" is found under `&.lecture`).

{% for calendar in site.calendars %}
  {{ calendar }}
{% endfor %}

<!-- {: .fs-4}
<a class="btn btn-blue" href="https://calendar.google.com/calendar?cid={{ site.google_calendar.google_calendar_id }}" target="_blank">Add to Google Calendar</a> -->


<!-- This page must include an element with a #full-calendar id -->
<!-- <div id="full-calendar" style="width: 100%"></div> -->
