#!/bin/bash

# MiastoX Setup Script
# Installs all dependencies and configures development environment

set -e

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${GREEN}[SETUP]${NC} $1"; }
print_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARN]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

echo "=== MiastoX Setup ==="
echo ""

install_aftman() {
    print_status "Setting up aftman..."
    if ! command -v aftman &> /dev/null; then
        print_info "Installing aftman..."
        cargo install aftman
        print_status "aftman installed"
    else
        print_info "aftman already installed"
    fi
}

install_rojo() {
    print_status "Setting up Rojo..."
    if ! command -v rojo &> /dev/null; then
        print_info "Installing Rojo..."
        cargo install rojo --locked
        print_status "Rojo installed"
    else
        print_info "Rojo already installed"
    fi
}

install_selene() {
    print_status "Setting up Selene..."
    if ! command -v selene &> /dev/null; then
        print_info "Installing Selene..."
        cargo install selene
        print_status "Selene installed"
    else
        print_info "Selene already installed"
    fi
}

install_stylua() {
    print_status "Setting up StyLua..."
    if ! command -v stylua &> /dev/null; then
        print_info "Installing StyLua..."
        cargo install stylua --features luau
        print_status "StyLua installed"
    else
        print_info "StyLua already installed"
    fi
}

install_darklua() {
    print_status "Setting up DarkLua..."
    if ! command -v darklua &> /dev/null; then
        print_info "Installing DarkLua..."
        cargo install darklua
        print_status "DarkLua installed"
    else
        print_info "DarkLua already installed"
    fi
}

install_wally() {
    print_status "Setting up Wally..."
    if ! command -v wally &> /dev/null; then
        print_info "Installing Wally..."
        cargo install wally-convert
        print_status "Wally installed"
    else
        print_info "Wally already installed"
    fi
}

install_packages() {
    print_status "Installing Wally packages..."
    if command -v wally &> /dev/null; then
        wally install
        print_status "Packages installed"
    else
        print_warning "Wally not found, skipping packages"
    fi
}

configure_git() {
    print_status "Configuring Git hooks..."
    
    if [ -d ".git" ]; then
        if [ ! -f ".git/hooks/pre-commit" ]; then
            mkdir -p .git/hooks
            cat > .git/hooks/pre-commit << 'HOOK'
#!/bin/bash
echo "Running pre-commit checks..."

if command -v stylua &> /dev/null; then
    stylua src --check --config stylua.toml || { echo "Format errors"; exit 1; }
fi

if command -v selene &> /dev/null; then
    selene src --config selene.toml || { echo "Lint errors"; exit 1; }
fi

echo "Pre-commit checks passed"
HOOK
            chmod +x .git/hooks/pre-commit
            print_status "Pre-commit hook installed"
        fi
    fi
}

verify_installation() {
    print_status "Verifying installation..."
    
    echo ""
    echo "Installed tools:"
    echo "  aftman:   $(command -v aftman &> /dev/null && aftman --version || echo 'not found')"
    echo "  Rojo:     $(command -v rojo &> /dev/null && rojo --version || echo 'not found')"
    echo "  Selene:   $(command -v selene &> /dev/null && selene --version || echo 'not found')"
    echo "  StyLua:   $(command -v stylua &> /dev/null && stylua --version || echo 'not found')"
    echo "  DarkLua:  $(command -v darklua &> /dev/null && darklua --version || echo 'not found')"
    echo "  Wally:    $(command -v wally &> /dev/null && wally --version || echo 'not found')"
    echo ""
    
    print_status "Setup complete!"
}

main() {
    install_aftman
    install_rojo
    install_selene
    install_stylua
    install_darklua
    install_wally
    install_packages
    configure_git
    verify_installation
}

case "${1:-}" in
    aftman) install_aftman ;;
    rojo) install_rojo ;;
    selene) install_selene ;;
    stylua) install_stylua ;;
    darklua) install_darklua ;;
    wally) install_wally ;;
    all) main ;;
    *) main ;;
esac