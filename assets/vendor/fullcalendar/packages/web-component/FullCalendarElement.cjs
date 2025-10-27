'use strict';

var index_cjs = require('@fullcalendar/core/index.cjs');

class FullCalendarElement extends HTMLElement {
    constructor() {
        super(...arguments);
        this._calendar = null;
        this._options = null;
    }
    connectedCallback() {
        this._handleOptionsStr(this.getAttribute('options'));
    }
    disconnectedCallback() {
        this._handleOptionsStr(null);
    }
    attributeChangedCallback(name, oldVal, newVal) {
        if (name === 'options' &&
            this._calendar // initial render happened
        ) {
            this._handleOptionsStr(newVal);
        }
    }
    get options() {
        return this._options;
    }
    set options(options) {
        this._handleOptions(options);
    }
    getApi() {
        return this._calendar;
    }
    _handleOptionsStr(optionsStr) {
        this._handleOptions(optionsStr ? JSON.parse(optionsStr) : null);
    }
    _handleOptions(options) {
        if (options) {
            if (this._calendar) {
                this._calendar.resetOptions(options);
            }
            else {
                let root;
                if (this.hasAttribute('shadow')) {
                    this.attachShadow({ mode: 'open' });
                    root = this.shadowRoot;
                }
                else {
                    // eslint-disable-next-line @typescript-eslint/no-this-alias
                    root = this;
                }
                root.innerHTML = '<div></div>';
                let calendarEl = root.querySelector('div');
                let calendar = new index_cjs.Calendar(calendarEl, options);
                calendar.render();
                this._calendar = calendar;
            }
            this._options = options;
        }
        else {
            if (this._calendar) {
                this._calendar.destroy();
                this._calendar = null;
            }
            this._options = null;
        }
    }
    static get observedAttributes() {
        return ['options'];
    }
}

exports.FullCalendarElement = FullCalendarElement;
