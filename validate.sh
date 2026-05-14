#!/bin/bash
# Pre-commit validation: lint all sources and catch rendering issues
set -o pipefail

errors=0
fail() { echo "FAIL: $1"; errors=$((errors + 1)); }
ok()   { echo "  OK: $1"; }

echo "=== Linting ==="

# JSON: validate syntax
if uv run python -c "import json, sys; json.load(open('data.json', encoding='utf-8')); sys.exit(0)" 2>/dev/null; then
    ok "data.json is valid JSON"
else
    fail "data.json is invalid JSON"
fi

# HTML: check for common issues that break rendering
if [ -f index.html ]; then
    # Unclosed template literals (backtick mismatch)
    backticks=$(grep -o '`' index.html | wc -l)
    if [ $((backticks % 2)) -ne 0 ]; then
        fail "index.html has unmatched backticks (template literal not closed)"
    else
        ok "index.html template literals balanced"
    fi

    # Mismatched script tags
    open_scripts=$(grep -oc '<script' index.html)
    close_scripts=$(grep -oc '</script>' index.html)
    if [ "$open_scripts" -ne "$close_scripts" ]; then
        fail "index.html has mismatched <script> tags ($open_scripts open, $close_scripts close)"
    else
        ok "index.html script tags balanced"
    fi

    # Check fetch('data.json') is present (rendering depends on it)
    if grep -q "fetch('data.json')" index.html; then
        ok "index.html fetches data.json"
    else
        fail "index.html missing fetch('data.json') — site will be blank"
    fi
else
    fail "index.html not found"
fi

# Typst: compile and check for errors
if command -v typst &>/dev/null; then
    if typst compile cv.typ /dev/null 2>&1 | grep -qi "error"; then
        fail "cv.typ has Typst compilation errors"
        typst compile cv.typ /dev/null 2>&1
    else
        ok "cv.typ compiles without errors"
    fi
else
    echo "SKIP: typst not in PATH, cannot lint cv.typ"
fi

echo ""
echo "=== Data integrity ==="

# Required top-level fields
for field in name title summary contact experience education skills projects; do
    if grep -q "\"$field\"" data.json; then
        ok "data.json has '$field'"
    else
        fail "data.json missing required field '$field'"
    fi
done

# Experience entries have required sub-fields
exp_roles=$(uv run python -c "
import json
data = json.load(open('data.json', encoding='utf-8'))
missing = []
for i, e in enumerate(data.get('experience', [])):
    for f in ['role', 'company', 'department', 'start', 'end', 'location', 'items']:
        if f not in e:
            missing.append(f'experience[{i}] missing {f}')
print('\n'.join(missing) if missing else 'OK')
" 2>/dev/null)
if [ -z "$exp_roles" ] || [ "$exp_roles" = "OK" ]; then
    ok "all experience entries have required fields"
else
    echo "$exp_roles" | while read -r line; do [ -n "$line" ] && fail "$line"; done
fi

echo ""
echo "=== Security ==="

# No phone numbers in HTML
if grep -qP '\+\d{1,3}[\s-]?\d{2,4}[\s-]?\d{3,4}[\s-]?\d{3,4}' index.html 2>/dev/null || \
   grep -qE '\+[0-9]{1,3}[[:space:]-]?[0-9]{2,4}[[:space:]-]?[0-9]{3,4}[[:space:]-]?[0-9]{3,4}' index.html; then
    fail "index.html contains a phone number"
else
    ok "no phone numbers in index.html"
fi

# No hardcoded email in HTML (should come from data.json)
if grep -q 'anil\.sezgin@' index.html; then
    fail "index.html has hardcoded email address"
else
    ok "no hardcoded email in index.html"
fi

echo ""
if [ $errors -gt 0 ]; then
    echo "FAILED: $errors error(s) found"
    exit 1
else
    echo "ALL CHECKS PASSED"
    exit 0
fi
