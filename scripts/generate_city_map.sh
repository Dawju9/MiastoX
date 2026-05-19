#!/usr/bin/env bash
# Generate a city map JSON using the external `schematicsagent` tool.
# If the tool is not available, a minimal fallback map is written.

OUTPUT_DIR="$(dirname "$0")/../assets"
OUTPUT_FILE="$OUTPUT_DIR/city_map.json"

mkdir -p "$OUTPUT_DIR"

if command -v schematicsagent >/dev/null 2>&1; then
    echo "Running schematicsagent to generate city map..."
    schematicsagent --export-json "$OUTPUT_FILE"
    if [[ $? -eq 0 && -s "$OUTPUT_FILE" ]]; then
        echo "City map generated at $OUTPUT_FILE"
        exit 0
    else
        echo "schematicsagent failed or produced empty output. Falling back to stub map."
    fi
else
    echo "schematicsagent not found in PATH. Using stub map."
fi

# Fallback stub map (same as assets/city_map.json already provided)
cat > "$OUTPUT_FILE" <<'EOF'
{
  "blocks": [
    {"id":1,"type":"city","position":{"x":0,"y":0,"z":0},"difficulty":"easy"},
    {"id":2,"type":"city","position":{"x":150,"y":0,"z":0},"difficulty":"medium"},
    {"id":3,"type":"city","position":{"x":0,"y":0,"z":150},"difficulty":"hard"},
    {"id":4,"type":"city","position":{"x":-150,"y":0,"z":0},"difficulty":"extreme"}
  ]
}
EOF

echo "Fallback city map written to $OUTPUT_FILE"
