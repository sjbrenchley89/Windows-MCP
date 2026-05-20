#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR}"

# Create virtual environment if it doesn't exist
uv venv --python 3.13

# Install dev tools (ruff, pytest, pytest-asyncio)
uv pip install ruff pytest pytest-asyncio

# Install all Linux-compatible runtime dependencies (pywin32 only runs on Windows)
uv pip install \
  click fastmcp fuzzywuzzy markdownify pillow platformdirs \
  posthog psutil python-levenshtein requests tabulate thefuzz uuid7

# Install the project itself without its hard dependencies (pywin32 is Windows-only)
uv pip install --no-deps -e .
