(function () {
	'use strict';

	const intervalMs = 1000; // check every second for real-time updates

	function parseDate(d) {
		if (!d) return null;
		const t = new Date(d);
		return isNaN(t.getTime()) ? null : t;
	}

	function disableAnchor(a) {
		if (!a) return;
		if (a.hasAttribute('data-href')) return; // already disabled

		// store original href
		const href = a.getAttribute('href');
		if (href !== null) a.setAttribute('data-href', href);

		// store existing tabindex if any so we can restore it
		if (a.hasAttribute('tabindex')) {
			a.setAttribute('data-tabindex', a.getAttribute('tabindex'));
		}

		// remove navigation and make inert
		a.removeAttribute('href');
		a.classList.add('unreleased');
		a.setAttribute('aria-disabled', 'true');
		a.setAttribute('tabindex', '-1');

		// make the link look like surrounding text by copying computed color
		try {
			const parent = a.parentElement || document.body;
			const normalColor = window.getComputedStyle(parent).color || '';
			a.style.color = normalColor;
			a.style.textDecoration = 'none';
			a.style.cursor = 'default';
		} catch (e) {
			// ignore if computed style is not available
		}
	}

	function enableAnchor(a) {
		if (!a) return;
		if (a.hasAttribute('href')) return; // already enabled

		const stored = a.getAttribute('data-href');
		if (stored) {
			a.setAttribute('href', stored);
			a.removeAttribute('data-href');
		}

		// restore tabindex if we saved one
		if (a.hasAttribute('data-tabindex')) {
			a.setAttribute('tabindex', a.getAttribute('data-tabindex'));
			a.removeAttribute('data-tabindex');
		} else {
			a.removeAttribute('tabindex');
		}

		a.classList.remove('unreleased');
		a.removeAttribute('aria-disabled');

		// remove inline styles we added
		a.style.color = '';
		a.style.textDecoration = '';
		a.style.cursor = '';
	}

	function refresh() {
		const now = new Date();
		const anchors = document.querySelectorAll('a[data-release]');
		anchors.forEach(anchor => {
			const ds = anchor.getAttribute('data-release');
			const release = parseDate(ds);
			if (!release) return; // malformed date — skip
			if (release > now) {
				disableAnchor(anchor);
			} else {
				enableAnchor(anchor);
			}
		});
	}

	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', () => {
			refresh();
			setInterval(refresh, intervalMs);
		});
	} else {
		refresh();
		setInterval(refresh, intervalMs);
	}

})();

