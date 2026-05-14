@echo off
echo Starting dev server at http://localhost:8000
echo Press Ctrl+C to stop
uv run python -m http.server 8000
