#!/usr/bin/env python3
"""
update_week_dates.py

Update only the date lines in existing week markdown files (e.g. `_modules/week-01.md`)
given a new semester start date. Useful when reusing content from a previous
semester — this preserves event text (Lecture/Homework/etc.) but adjusts the
calendar dates.

Usage:
  python3 script/update_week_dates.py --start "2025-08-24"  # ISO date
  python3 script/update_week_dates.py --start "Aug 24" --year 2025

Options:
  --dir DIR       directory containing week files (default: _modules)
  --pattern REGEX filename regex with a capture group for week number
                  (default: 'week-(\\d+)\\.md')
  --dry-run       print planned changes instead of writing files
  --backup        create a .bak copy of each file before modifying

Behavior:
  - Files matching the pattern are located and processed in numeric week order.
  - For week N, the script computes week_start = start_date + (N-1) * 7 days
  - It replaces the first up-to-five date lines in the file (one per weekday)
    with the dates for Mon..Fri of that week, preserving the rest of the file.
  - Date format matches the existing site style: 'Aug 24' (month abbrev and
    day without leading zero).

"""
from __future__ import annotations

import argparse
import datetime
import os
import re
import sys
from typing import List, Tuple

MONTH_ABBR_RE = r"(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)"
DATE_LINE_RE = re.compile(rf"^\s*({MONTH_ABBR_RE})\s+(\d{{1,2}})\s*$")


def parse_start_date(s: str, default_year: int | None) -> datetime.date:
    s = s.strip()
    # Try ISO first
    try:
        return datetime.datetime.strptime(s, "%Y-%m-%d").date()
    except Exception:
        pass
    # Try month name formats
    try:
        parts = s.split()
        if len(parts) == 3:
            return datetime.datetime.strptime(s, "%b %d %Y").date()
        elif len(parts) == 2:
            if default_year is None:
                raise ValueError("Year required when providing month/day without year; use --year")
            return datetime.datetime.strptime(f"{s} {default_year}", "%b %d %Y").date()
    except Exception as e:
        raise ValueError(f"Could not parse start date: {s}: {e}")


def format_date_for_md(d: datetime.date) -> str:
    # Use platform-safe day formatting: no leading zero
    # %e isn't portable; use day int
    return d.strftime('%b ') + str(d.day)


def find_week_files(dirpath: str, pattern: str) -> List[Tuple[int, str]]:
    regex = re.compile(pattern)
    results: List[Tuple[int, str]] = []
    for name in os.listdir(dirpath):
        m = regex.match(name)
        if m:
            try:
                week_num = int(m.group(1))
            except Exception:
                continue
            results.append((week_num, os.path.join(dirpath, name)))
    results.sort()
    return results


def update_file_dates(path: str, week_start: datetime.date, dry_run: bool = False, backup: bool = False) -> Tuple[bool, int]:
    """Update up to five date lines in file at path to Mon..Fri starting at week_start.
    Returns (changed, count_replaced).
    """
    with open(path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    new_lines: List[str] = []
    replaced = 0
    day_idx = 0

    for line in lines:
        if day_idx < 5 and DATE_LINE_RE.match(line):
            # replace with computed date for this weekday
            new_date = week_start + datetime.timedelta(days=day_idx)
            new_line = format_date_for_md(new_date) + "\n"
            new_lines.append(new_line)
            replaced += 1
            day_idx += 1
        else:
            new_lines.append(line)

    changed = new_lines != lines
    if not changed:
        return False, replaced

    if dry_run:
        print(f"Would update {path}: replaced {replaced} date lines")
        return True, replaced

    if backup:
        bak = path + '.bak'
        with open(bak, 'w', encoding='utf-8') as f:
            f.writelines(lines)

    with open(path, 'w', encoding='utf-8') as f:
        f.writelines(new_lines)

    return True, replaced


def main():
    p = argparse.ArgumentParser(description="Update date lines in week markdown files")
    p.add_argument('--start', required=True, help='Start date (YYYY-MM-DD or "Aug 24" )')
    p.add_argument('--year', type=int, help='Year when start date omits year')
    p.add_argument('--dir', default='_modules', help='Directory with week files')
    p.add_argument(
        '--pattern',
        default=r'week-(\d+)\.md',
        help='Filename regex with capture group for week number (default: week-(\\d+)\\.md)'
    )
    p.add_argument('--dry-run', action='store_true', help='Show planned changes without writing files')
    p.add_argument('--backup', action='store_true', help='Create a .bak copy before modifying')
    args = p.parse_args()

    try:
        start_date = parse_start_date(args.start, args.year)
    except ValueError as e:
        print(e)
        sys.exit(2)

    files = find_week_files(args.dir, args.pattern)
    if not files:
        print(f"No files matching pattern in {args.dir}")
        sys.exit(1)

    total_replaced = 0
    total_changed = 0

    for week_num, path in files:
        week_start = start_date + datetime.timedelta(weeks=week_num - 1)
        changed, replaced = update_file_dates(path, week_start, dry_run=args.dry_run, backup=args.backup)
        if changed:
            total_changed += 1
        total_replaced += replaced
        print(f"Processed {os.path.basename(path)}: replaced {replaced} date lines{' (updated)' if changed else ''}")

    print(f"Done. {total_changed} files updated, {total_replaced} date lines replaced.")


if __name__ == '__main__':
    main()
