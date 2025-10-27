import { F as FullCalendarElement } from './FullCalendarElement.js';
import '@fullcalendar/core/index.js';

globalThis.FullCalendarElement = FullCalendarElement;
customElements.define('full-calendar', FullCalendarElement);
