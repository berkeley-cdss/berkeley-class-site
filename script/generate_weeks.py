#!/usr/bin/env python3
"""
generate_weeks.py

Generate a set of week markdown files under `_modules/` for a course schedule.

Usage examples:
  # generate 17 weeks starting Aug 24, 2025 (Monday)
  ./script/generate_weeks.py --start "2025-08-24" --weeks 17

  # shorter syntax (month name + day) and explicit year
  ./script/generate_weeks.py --start "Aug 24" --year 2025

Options of interest:
  --weeks N            number of week files to generate (default: 17)
  --start DATE         start date (YYYY-MM-DD or 'Aug 24'). If month/day only, use --year.
  --year YYYY          year to use when start date doesn't include one.
  --outdir PATH        directory to write files (default: _modules)
  --hw-start N         starting homework number (default: 1)
  --map MAP            optional event placement mapping (see README below)

Default behavior
  - Discussions on Mondays
  - Homeworks on Wednesdays (sequential HW numbers)
  - Lectures on Tuesdays and Thursdays (links generated using lecture numbers = week number)
  - Labs on Fridays (optional)

Each generated file is named `week-XX.md` with a title in the front matter.

"""
from __future__ import annotations

import argparse
import datetime
import os
import sys
from typing import Dict, List, Tuple

WEEKDAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

DEFAULT_MAPPING = {
    "Monday": ["Discussion"],
    "Tuesday": ["Lecture"],
    "Wednesday": ["Homework"],
    "Thursday": ["Lecture"],
    "Friday": ["Lab"],
}

TEMPLATE_DAY_BLOCK = "{date}\n: **{event_label}**{{: .label .label-{event_class} }} {link}\n"


def parse_args():
    p = argparse.ArgumentParser(description="Generate week markdown files for course schedule")
    p.add_argument("--start", help="Start date (YYYY-MM-DD or 'Aug 24' or 'Aug 24 2025'); if omitted the script will prompt interactively")
    p.add_argument("--year", type=int, help="Year when start date omits year")
    p.add_argument("--weeks", type=int, default=17, help="Number of weeks to generate")
    p.add_argument("--outdir", default="_modules", help="Output directory (default: _modules)")
    p.add_argument("--hw-start", type=int, default=1, help="Starting homework number (default 1)")
    p.add_argument("--map", help="Optional mapping like 'Mon:Discussion;Wed:Homework' to override defaults")
    return p.parse_args()


def interactive_fill(args):
    """Prompt the user for missing arguments interactively."""
    def ask(prompt: str, default: str | None = None) -> str:
        if default is None:
            while True:
                v = input(f"{prompt}: ").strip()
                if v:
                    return v
        else:
            v = input(f"{prompt} [{default}]: ").strip()
            return v if v else default

    if not args.start:
        args.start = ask("Start date (YYYY-MM-DD or 'Aug 24' or 'Aug 24 2025')")
    # if start lacks year and year not provided, prompt for year
    tokens = args.start.split()
    if len(tokens) == 2 and not args.year:
        year_str = ask("Year for the start date (e.g. 2025)")
        try:
            args.year = int(year_str)
        except Exception:
            print("Invalid year entered; continuing without explicit year.")

    # other options
    if args.weeks is None:
        args.weeks = int(ask("Number of weeks to generate", "17"))
    else:
        # offer to confirm or change
        val = ask("Number of weeks to generate", str(args.weeks))
        try:
            args.weeks = int(val)
        except Exception:
            pass

    args.outdir = ask("Output directory", args.outdir)
    hw_val = ask("Starting homework number", str(args.hw_start))
    try:
        args.hw_start = int(hw_val)
    except Exception:
        pass
    map_val = ask("Optional mapping (e.g. 'Mon:Discussion;Wed:Homework') or leave blank", args.map or "")
    args.map = map_val if map_val.strip() else None


def parse_start_date(s: str, default_year: int | None) -> datetime.date:
    s = s.strip()
    # Try ISO first
    try:
        return datetime.datetime.strptime(s, "%Y-%m-%d").date()
    except Exception:
        pass
    # Try month name formats
    try:
        # If user gave 'Aug 24 2025' or 'Aug 24'
        parts = s.split()
        if len(parts) == 3:
            return datetime.datetime.strptime(s, "%b %d %Y").date()
        elif len(parts) == 2:
            if default_year is None:
                raise ValueError("Year required when providing month/day without year; use --year")
            return datetime.datetime.strptime(f"{s} {default_year}", "%b %d %Y").date()
    except Exception:
        pass
    raise ValueError(f"Could not parse start date: {s}")


def build_mapping(map_arg: str | None) -> Dict[str, List[str]]:
    mapping = DEFAULT_MAPPING.copy()
    if not map_arg:
        return mapping
    # map_arg format: 'Mon:Discussion;Wed:Homework'
    entries = [e.strip() for e in map_arg.split(';') if e.strip()]
    for e in entries:
        if ':' not in e:
            continue
        k, v = e.split(':', 1)
        # Normalize weekday names to full name if short provided
        k = k.strip()
        k_full = normalize_weekday_name(k)
        mapping[k_full] = [x.strip() for x in v.split(',') if x.strip()]
    return mapping


def normalize_weekday_name(short: str) -> str:
    s = short.strip().lower()
    for name in WEEKDAYS:
        if name.lower().startswith(s):
            return name
    raise ValueError(f"Unknown weekday name: {short}")


def mkdir_p(path: str):
    os.makedirs(path, exist_ok=True)


def format_date_for_md(d: datetime.date) -> str:
    # e.g. Aug 24 (no leading zero)
    return d.strftime('%b %-d') if sys.platform != 'win32' else d.strftime('%b %#d')


def zero_pad(n: int, width: int = 2) -> str:
    return str(n).zfill(width)


def event_class_for_label(label: str) -> str:
    return label.lower().replace(' ', '-')


def event_link_for(label: str, week_num: int, hw_counter: int) -> Tuple[str, int]:
    """Return (link_markdown, possibly_updated_hw_counter)"""
    label_lower = label.lower()
    week_num = 1
    if label_lower.startswith('discussion'):
        return "[Discussion](#)", hw_counter
    if label_lower.startswith('homework') or label_lower.startswith('hw'):
        hw_num = hw_counter
        hw_padded = zero_pad(hw_num)
        # Use doubled braces so Python .format treats them as literal braces
        link = "[HW {}]({{% link _hw/hw{}.md %}})".format(hw_num, hw_padded)
        # above uses raw markers to avoid evaluating liquid when this script runs
        return link, hw_counter
    if label_lower.startswith('lecture'):
        lec_num = zero_pad(week_num)
        link = "[Lecture {}]({{% link _lectures/{}.md %}})".format(week_num, lec_num)
        return link, hw_counter
    if label_lower.startswith('lab'):
        # attempt to link to labs by week_num if desired
        lab_name = f"lab{zero_pad(week_num)}"
        link = "[Lab {}]({{% link _labs/{}.md %}})".format(week_num, lab_name)
        return link, hw_counter
    # fallback
    return "(#)", hw_counter


def generate_week_content(week_index: int, start_date: datetime.date, mapping: Dict[str, List[str]], hw_counter_start: int) -> Tuple[str, int]:
    """Generate markdown content for a single week (1-based week_index). Returns (content, next_hw_counter)."""
    week_start = start_date + datetime.timedelta(weeks=week_index - 1)
    content_lines: List[str] = []
    # Front matter
    title = f"Week {zero_pad(week_index)}"
    content_lines.append('---')
    content_lines.append(f'title: {title}')
    content_lines.append('---')
    content_lines.append('')

    hw_counter = hw_counter_start
    # iterate Monday..Friday
    for i in range(5):
        day = week_start + datetime.timedelta(days=i)
        day_name = day.strftime('%A')
        date_str = format_date_for_md(day)
        if day_name not in mapping:
            # no events for this day - still print the date
            content_lines.append(date_str)
            content_lines.append(':')
            continue
        events = mapping[day_name]
        # Print the date once, then each event on its own indented line
        content_lines.append(date_str)
        first = True
        for ev in events:
            link, hw_counter = event_link_for(ev, week_index, hw_counter)
            ev_class = event_class_for_label(ev)
            prefix = ': ' if first else '  : '
            line = f"{prefix}**{ev}**{{: .label .label-{ev_class} }} {link}"
            content_lines.append(line)
            first = False
        # blank line after the day's events for readability
        content_lines.append('')
    body = '\n'.join(content_lines)
    return body, hw_counter


def write_week_file(outdir: str, week_index: int, content: str):
    mkdir_p(outdir)
    filename = os.path.join(outdir, f"week-{zero_pad(week_index)}.md")
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"Wrote {filename}")


def main():
    args = parse_args()
    if not args.start:
        interactive_fill(args)
    try:
        start_date = parse_start_date(args.start, args.year)
    except ValueError as e:
        print(e)
        sys.exit(2)

    mapping = build_mapping(args.map)
    hw_counter = args.hw_start

    for w in range(1, args.weeks + 1):
        content, hw_counter = generate_week_content(w, start_date, mapping, hw_counter)
        write_week_file(args.outdir, w, content)

    print('Done.')


if __name__ == '__main__':
    main()
