#!/usr/bin/env bash
set -e
# Auto‑commit all changes, bump the project version, and push.
# The version is stored in config.toml as: version = "X.Y.Z"

CONFIG_FILE="config.toml"
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Error: $CONFIG_FILE not found" >&2
  exit 1
fi

# Extract current version
CURRENT=$(awk -F'"' '/^version[[:space:]]*=/ {print $2; exit}' "$CONFIG_FILE")
if [[ -z "$CURRENT" ]]; then
  echo "Error: could not parse version from $CONFIG_FILE" >&2
  exit 1
fi

IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT"
PATCH=$((PATCH+1))
NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"

echo "Bumping version: $CURRENT → $NEW_VERSION"

# Update the version line in config.toml (preserve surrounding formatting)
sed -i "s/^version = \".*\"/version = \"${NEW_VERSION}\"/" "$CONFIG_FILE"

# Stage all changes, commit and push
git add -A
git commit -m "chore: bump version to ${NEW_VERSION}"

git push

echo "Done – changes committed and pushed."
