#!/bin/bash
set -euo errtrace

error_handle() {
    echo "error: ${BASH_SOURCE[1]} at line ${BASH_LINENO[0]}"
    echo "Are you sure you ran the install.sh script?"
}
trap error_handle ERR

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR"

BUILD_TYPE="${1:-production}"

echo "=== MiastoX Build ==="
echo "Build type: $BUILD_TYPE"
echo ""

case "$BUILD_TYPE" in
    production|prod)
        echo "Building production version..."
        PROJECT_FILE="default.project.json"
        OUTPUT_FILE="MiastoX.rbxl"
        ;;
    build)
        echo "Building (same as production)..."
        PROJECT_FILE="default.project.json"
        OUTPUT_FILE="MiastoX.rbxl"
        ;;
    dev|development)
        echo "Building development version..."
        PROJECT_FILE="dev.project.json"
        OUTPUT_FILE="MiastoX-Dev.rbxl"
        ;;
    test)
        echo "Building test version..."
        PROJECT_FILE="test.project.json"
        OUTPUT_FILE="MiastoX-Test.rbxl"
        ;;
    *)
        echo "Usage: $0 [production|dev|test]"
        echo ""
        echo "Examples:"
        echo "  $0           # production (default)"
        echo "  $0 production"
        echo "  $0 dev"
        echo "  $0 test"
        exit 1
        ;;
esac

echo "Project: $PROJECT_FILE"
echo "Output: $OUTPUT_FILE"
echo ""

rojo build "$PROJECT_FILE" -o "$OUTPUT_FILE"

echo ""
echo "=== Build Complete ==="
echo "Output: $OUTPUT_FILE"