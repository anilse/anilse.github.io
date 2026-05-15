# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "html5lib",
# ]
# ///
"""Pre-commit validation: lint all sources and catch rendering issues."""

import json
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

import html5lib

# ── Helpers ──────────────────────────────────────────────────────────────

errors = 0


def fail(msg: str) -> None:
    global errors
    print(f"FAIL: {msg}")
    errors += 1


def ok(msg: str) -> None:
    print(f"  OK: {msg}")


def skip(msg: str) -> None:
    print(f"SKIP: {msg}")


# ── Linting ──────────────────────────────────────────────────────────────

print("=== Linting ===")

# JSON syntax
data = None
try:
    data = json.loads(Path("data.json").read_text(encoding="utf-8"))
    ok("data.json is valid JSON")
except json.JSONDecodeError as e:
    fail(f"data.json: {e}")
except FileNotFoundError:
    fail("data.json not found")

# HTML5 parse errors
html_path = Path("index.html")
html_src = ""
if html_path.exists():
    html_src = html_path.read_text(encoding="utf-8")
    parser = html5lib.HTMLParser()
    parser.parse(html_src)
    parse_errors = parser.errors
    if parse_errors:
        fail(f"index.html has {len(parse_errors)} HTML5 parse error(s)")
        for (line, col), errorcode, datavars in parse_errors[:5]:
            print(f"       line {line}:{col}  {errorcode}")
        if len(parse_errors) > 5:
            print(f"       ... and {len(parse_errors) - 5} more")
    else:
        ok("index.html is valid HTML5")

    if "fetch('data.json')" in html_src or 'fetch("data.json")' in html_src:
        ok("index.html fetches data.json")
    else:
        fail("index.html missing fetch('data.json') — site will be blank")
else:
    fail("index.html not found")

# Typst compilation
if shutil.which("typst"):
    result = subprocess.run(
        ["typst", "compile", "cv.typ", "--format", "pdf", os.devnull],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0 or "error" in result.stderr.lower():
        fail("cv.typ has Typst compilation errors")
        print(result.stderr)
    else:
        ok("cv.typ compiles without errors")
else:
    skip("typst not in PATH, cannot lint cv.typ")

# ── Data integrity ───────────────────────────────────────────────────────

print("\n=== Data integrity ===")

if data is not None:
    required_top = ("name", "title", "summary", "contact", "experience", "education", "skills", "projects")
    for field in required_top:
        if field in data:
            ok(f"data.json has '{field}'")
        else:
            fail(f"data.json missing required field '{field}'")

    required_exp = ("role", "company", "department", "start", "end", "location", "items")
    exp_ok = True
    for i, entry in enumerate(data.get("experience", [])):
        for f in required_exp:
            if f not in entry:
                fail(f"experience[{i}] missing '{f}'")
                exp_ok = False
    if exp_ok:
        ok("all experience entries have required fields")

# ── Security ─────────────────────────────────────────────────────────────

print("\n=== Security ===")

if html_src:
    phone_re = r"\+\d{1,3}[\s-]?\d{2,4}[\s-]?\d{3,4}[\s-]?\d{3,4}"
    if re.search(phone_re, html_src):
        fail("index.html contains a phone number")
    else:
        ok("no phone numbers in index.html")

    if "anil.sezgin@" in html_src.lower():
        fail("index.html has hardcoded email address")
    else:
        ok("no hardcoded email in index.html")

# ── Result ───────────────────────────────────────────────────────────────

print()
if errors:
    print(f"FAILED: {errors} error(s) found")
    sys.exit(1)
else:
    print("ALL CHECKS PASSED")
