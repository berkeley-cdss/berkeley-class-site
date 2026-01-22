---
layout: calendar_dynamic
title: Calendar (Dynamic)
description: Lecture, Discussion and OH schedules
nav_order: 3
---

# Calendar (Dynamic)
Use this calendar if you want to integrate your class's Google Calendar into the website. 

## Directions
1. Ensure there is a calendar for your course. You may reuse the previous semester's calendar if it exists. We suggest that calendars belong to a course's SPA. [Directions for creating a new calendar here.](https://support.google.com/calendar/answer/37095?hl=en)
1. In `config.yml`, set `google_calendar_id` to the calendar's Calendar ID from the [settings page](https://support.google.com/calendar/answer/6084644?hl=en&co=GENIE.Platform%3DDesktop). 
1. Create a Google API Key. You may be able to reuse the previous semester's API key if one exists.
    1. If there is not a Google Cloud project associated with your course, [create a new project](https://developers.google.com/workspace/guides/create-project). You should ensure that the project you create is associated with your course SPA, or at the very least a @berkeley.edu email. Doing so will ensure that you create the project under Berkeley/Learning and any associated billing will be taken care of by the university.
    1. Access "APIs & Services" from the left side bar.
    1. Click "Create credentials" -> "API key." Set `google_api_key` in `config.yml` to the key you obtain. 
    1. Click on the newly created key to update the settings. Rename the key to something more useful like "COURSE NAME Calendar Key." Under "Application restrictions" choose "Websites" and add a restriction for your course website (use the single domain, e.g. "https://data8.com"). If you want to be able to view the calendar on a local deployment you should also add "http://127.0.0.1:4000/". Don't forget to click "Save."
    1. Enable the [Google Calendar API](https://console.cloud.google.com/apis/api/calendar-json.googleapis.com/metrics?). [Instructions here](https://support.google.com/googleapi/answer/6158841?hl=en)
1. Create calendar events for your class using this new calendar. 
    1. You may want to take advantage of the [recurring event feature](https://support.google.com/calendar/answer/37115?hl=en&co=GENIE.Platform%3DDesktop).
    1. View/edit event types in the `event_types` section of `config.yml`. Your Google Calendar titles should have the appropriate prefix or suffix matching these event types. For example, if your calendar event title is "[Data 101] Lecture", `_config.yml` should have `suffix: Lecture`. If instead, your calendar event title is "Lecture - Pivots and Joins", `_config.yml` should have `prefix: Lecture`. We recommend only changing `suffix` / `prefix` and none of the other fields.

{: .note }
The above directions are based loosely on [this](https://fullcalendar.io/docs/google-calendar) which is now out of date.



## Properties of `event_types` in `config.yml`
- `prefix` / `suffix`: Looks at the prefix / suffix of an event and sets the styling if it finds a match (see above).
- `background_color`: Hex code for the background color.
- `text_color`: Hex code for the text color.
- `class`: Class ID of the event (e.g. `cal-lecture` for lecture events).
- `icon`: Fontawesome icon placed on the event (e.g. `fa-school`), more can be found in `fontawesome/css` or by visiting [fontawesome](https://fontawesome.com/).

**Note**: As you update the calendar, you'll find that some files use the phrase "fullcalendar" and some use "calendar_dynamic". Both refer to the dynamic calendar. fullcalendar is an open source JavaScript calendar we're using to deliver the dynamic calendar.
{: .fs-4}
<a class="btn btn-blue" href="https://calendar.google.com/calendar?cid={{ site.google_calendar.google_calendar_id }}" target="_blank">Add to Google Calendar</a>


<!-- This page must include an element with a #full-calendar id -->
<div id="full-calendar" style="width: 100%"></div>
