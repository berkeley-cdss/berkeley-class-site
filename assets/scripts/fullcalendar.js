---
---

let GOOGLE_CALENDAR_ID = '{{ site.google_calendar.google_calendar_id }}';
let EVENT_CONFIG = {{ site.google_calendar.event_types | jsonify }};

let extend_event = (event, config) => {
  if (config.background_color) {
      event.backgroundColor = `#${config.background_color}`;
      event.borderColor = '#FFFFFF';
    }
  if (config.text_color) { event.textColor = `#${config.text_color}`; }
  if (config.class) { event.classNames = config.class; }
  if (config.icon) {
    event.extendedProps ||= {};
    event.extendedProps.icon = config.icon;
  }
  return event;
}

let transform_calendar_event = (event) => {
  let title = event.title.trim();
  for (config of EVENT_CONFIG) {
    if (config.prefix && title.startsWith(config.prefix)) {
      return extend_event(event, config);
    }
    if (config.suffix && title.endsWith(config.suffix.trim())) {
      return extend_event(event, config);
    }
  }

  return event;
}

/* NOTES / Future Things:
 * Set initial date to start of semester if semester is over.
* https://fullcalendar.io/docs/date-navigation
*
*/
document.addEventListener('DOMContentLoaded', function() {
  let calendarEl = document.getElementById('full-calendar');
  let calendar = new FullCalendar.Calendar(calendarEl, {
    // plugins: [FullCalendar.TimeGrid, FullCalendar.GoogleCalendar],
    googleCalendarApiKey: '{{ site.google_calendar.google_api_key }}',
    initialView: 'timeGridWeek',
    // TODO: This should be configurable.
    weekends: false,
    nowIndicator: true,
    // eventMinHeight: 30,
    // TODO: 30 min default makes the calendar tall...
    // 1 hour is too compact?
    // slotDuration: '01:00:00',
    slotMinTime: '09:00:00',
    slotMaxTime: '21:00:00',
    contentHeight: 'auto',
    height: 'auto',
    // This is needed because the < > are not properly labelled for a11y
    buttonIcons: false,
    // More button customizations:
    // https://fullcalendar.io/docs/customButtons
    headerToolbar: {
      left: 'prev,next',
      center: 'title',
      right: 'timeGridWeek,timeGridDay' // user can switch between the two
    },
    eventClassNames: 'berkeley-calendar',
    eventSources: [
      {
        googleCalendarId: GOOGLE_CALENDAR_ID,
        eventDataTransform: transform_calendar_event,
      },
      {
        // UC Berkeley Student Services Calendar
        googleCalendarId: 'c_lublpqqigfijlbc1l4rudcpi5s@group.calendar.google.com',
        backgroundColor: '#B3E59A',
        textColor: '#000000',
      },
    ],
    // Additional Custom events
    events: [
       // A Recurring event around the assignment deadline
      //  {
      //   daysOfWeek: [ '3' ], // these recurrent events move separately
      //   startRecur: '2024-09-01',
      //   endRecur: '2024-12-10',
      //   startTime: '16:30:00',
      //   endTime: '17:00:00',
      //   // color: 'red',
      //   display: 'background',
      //   backgroundColor: '#B3E59A',
      //   textColor: '#000000',
      //   title: '5PM Regular Submission Deadline'
      // }
    ],
    eventDidMount: function(args) {
      // This can be called after the event is rendered to manipulate the dom...
      let props = args.event.extendedProps,
        location = '',
        icon = '';
      let titleEl = args.el.querySelector('.fc-event-title'),
          eventTitleContainer = args.el.querySelector('.fc-event-title-container'),
          eventTimeContainer = args.el.querySelector('.fc-event-main-frame'),
          eventTime = args.el.querySelector('.fc-event-time');

      if (eventTimeContainer && eventTitleContainer && eventTime) {
        eventTimeContainer.removeChild(eventTime);
        eventTitleContainer.appendChild(eventTime);
      }

      if (!props) { return; }
      if (props.icon) {
        icon = `<i class="fa-solid ${props.icon}" aria-hidden="true"></i>&nbsp;`
      }
      if (props.location) {
        location = `<br><span class="cal-event-location">${props.location}</span>`;
      }

      titleEl.innerHTML = `${icon}${titleEl.innerHTML}${location}`;
    }
  });
  calendar.render();
});