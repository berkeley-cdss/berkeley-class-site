'use strict';

var FullCalendarElement = require('./FullCalendarElement.cjs');
require('@fullcalendar/core/index.cjs');

globalThis.FullCalendarElement = FullCalendarElement.FullCalendarElement;
customElements.define('full-calendar', FullCalendarElement.FullCalendarElement);
