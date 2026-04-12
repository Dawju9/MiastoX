#!/bin/bash

# MiastoX Development Workflow
# Automated development commands

set -e

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${GREEN}[DEV]${NC} $1"; }
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARN]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_tool() {
    if command -v "$1" &> /dev/null; then
        return 0
    else
        print_warning "$1 not found"
        return 1
    fi
}

run_format() {
    print_status "Running StyLua formatter..."
    if check_tool stylua; then
        stylua src --config stylua.toml
        print_status "Formatted"
    else
        print_warning "Skipping format (stylua not installed)"
    fi
}

run_lint() {
    print_status "Running linters..."
    
    if check_tool selene; then
        selene src --config selene.toml || true
    else
        print_warning "Selene not installed"
    fi
    
    print_status "Lint complete"
}

run_preprocess() {
    print_status "Running DarkLua preprocessor..."
    if check_tool darklua; then
        darklua process src --config .darklua.json
        print_status "Preprocessed"
    else
        print_warning "Skipping preprocess (darklua not installed)"
    fi
}

run_build() {
    print_status "Building Roblox project..."
    if check_tool rojo; then
        rojo build default.project.json --output "MiastoX.rbxl"
        print_status "Built: MiastoX.rbxl"
    else
        print_error "Rojo required for build"
        exit 1
    fi
}

run_watch() {
    print_status "Starting watch mode..."
    if check_tool rojo; then
        rojo watch default.project.json
    else
        print_error "Rojo required for watch"
        exit 1
    fi
}

run_validate_config() {
    print_status "Validating config..."
    if check_tool toml-validate; then
        toml-validate config.toml
        print_status "Config valid"
    else
        print_info "toml-validate not found, skipping"
    fi
}

show_help() {
    echo "MiastoX Development Commands"
    echo ""
    echo "Usage: $0 <command>"
    echo ""
    echo "Commands:"
    echo "  format     - Run StyLua formatter"
    echo "  lint      - Run Selene linter"
    echo "  preprocess - Run DarkLua preprocessor"
    echo "  build     - Build Roblox project"
    echo "  watch     - Watch mode for development"
    echo "  validate  - Validate configuration"
    echo "  dev       - Full dev cycle (format + lint)"
    echo "  release   - Full release build"
    echo "  help      - Show this help"
    echo ""
}

case "${1:-}" in
    format)
        run_format
        ;;
    lint)
        run_lint
        ;;
    preprocess)
        run_preprocess
        ;;
    build)
        run_build
        ;;
    watch)
        run_watch
        ;;
    validate)
        run_validate_config
        ;;
    dev)
        run_format
        run_lint
        print_status "Dev cycle complete"
        ;;
    release)
        run_preprocess
        run_format
        run_lint
        run_build
        print_status "Release build complete"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        show_help
        ;;
esac