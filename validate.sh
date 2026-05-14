#!/bin/bash
# Pre-commit validation for portfolio site

errors=0

# 1. Validate data.json is valid JSON
if uv run python -c "import json; json.load(open('data.json'))" 2>/dev/null || \
   python -c "import json; json.load(open('data.json'))" 2>/dev/null || \
   python3 -c "import json; json.load(open('data.json'))" 2>/dev/null || \
   "$LOCALAPPDATA/Microsoft/WinGet/Packages/astral-sh.uv_Microsoft.Winget.Source_8wekyb3d8bbwe/uv.exe" run python -c "import json; json.load(open('data.json'))" 2>/dev/null; then
    echo "OK: data.json is valid JSON"
else
    echo "FAIL: data.json is not valid JSON (or no python found)"
    errors=$((errors + 1))
fi

# 2. Check required fields in data.json
for field in name title summary; do
    if ! grep -q "\"$field\"" data.json; then
        echo "FAIL: data.json missing required field '$field'"
        errors=$((errors + 1))
    fi
done
echo "OK: data.json has required fields"

# 3. Check index.html fetches data.json (not hardcoded data)
if grep -q "fetch('data.json')" index.html; then
    echo "OK: index.html fetches data.json"
else
    echo "FAIL: index.html does not fetch data.json"
    errors=$((errors + 1))
fi

# 4. Check no phone numbers leaked in index.html
if grep -qE '\+[0-9]{1,3}[\s-]?[0-9]{2,4}[\s-]?[0-9]{3,4}[\s-]?[0-9]{3,4}' index.html; then
    echo "FAIL: index.html contains a phone number"
    errors=$((errors + 1))
else
    echo "OK: no phone numbers in index.html"
fi

# 5. Check cv.typ reads from data.json
if grep -q 'json("data.json")' cv.typ; then
    echo "OK: cv.typ reads data.json"
else
    echo "FAIL: cv.typ does not read data.json"
    errors=$((errors + 1))
fi

echo ""
if [ $errors -gt 0 ]; then
    echo "FAILED: $errors error(s) found"
    exit 1
else
    echo "ALL CHECKS PASSED"
    exit 0
fi
