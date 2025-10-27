import { F as FullCalendarElement } from './FullCalendarElement.d.js';
import '@fullcalendar/core';

type FullCalendarElementType = typeof FullCalendarElement;
declare global {
    var FullCalendarElement: FullCalendarElementType;
    interface HTMLElementTagNameMap {
        'full-calendar': FullCalendarElement;
    }
}
//# sourceMappingURL=global.d.ts.map
