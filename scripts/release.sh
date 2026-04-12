#!/bin/bash

# MiastoX Release Workflow
# Builds and prepares release artifacts

set -e

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

VERSION="${1:-}"

print_status() { echo -e "${GREEN}[RELEASE]${NC} $1"; }
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_git() {
    if [ -d ".git" ]; then
        return 0
    else
        print_error "Not a git repository"
        return 1
    fi
}

update_version() {
    if [ -n "$VERSION" ]; then
        print_status "Updating version to $VERSION..."
        sed -i "s/version = \".*\"/version = \"$VERSION\"/" config.toml
        print_info "Version: $VERSION"
    fi
}

run_preprocess() {
    print_status "Running DarkLua preprocessor..."
    if command -v darklua &> /dev/null; then
        darklua process src --config .darklua.json
        print_status "Preprocessed"
    else
        print_info "Skipping preprocess"
    fi
}

run_format() {
    print_status "Running formatter..."
    if command -v stylua &> /dev/null; then
        stylua src --config stylua.toml
        print_status "Formatted"
    else
        print_info "Skipping format"
    fi
}

run_lint() {
    print_status "Running linters..."
    
    if command -v selene &> /dev/null; then
        selene src --config selene.toml || true
    fi
    
    print_status "Lint complete"
}

build_roblox() {
    print_status "Building Roblox project..."
    if command -v rojo &> /dev/null; then
        rojo build default.project.json --output "MiastoX-$VERSION.rbxl"
        print_status "Built: MiastoX-$VERSION.rbxl"
    else
        print_error "Rojo not found"
        return 1
    fi
}

validate_config() {
    print_status "Validating configuration..."
    if command -v toml-validate &> /dev/null; then
        toml-validate config.toml
        print_status "Config valid"
    else
        print_info "Skipping validation"
    fi
}

main() {
    echo "MiastoX Release Workflow"
    echo ""
    
    if [ -z "$VERSION" ]; then
        read -p "Enter version: " VERSION
    fi
    
    echo ""
    echo "=== Release $VERSION ==="
    echo ""
    
    update_version
    validate_config
    run_preprocess
    run_format
    run_lint
    build_roblox
    
    print_status "Release $VERSION ready!"
    echo ""
    echo "Next steps:"
    echo "  git add -A"
    echo "  git commit -m \"Release: $VERSION\""
    echo "  git tag v$VERSION"
    echo "  git push --tags"
}

case "${1:-}" in
    -h|--help)
        echo "Usage: $0 [version]"
        echo ""
        echo "Example:"
        echo "  $0 1.0.0"
        ;;
    *)
        main
        ;;
esac