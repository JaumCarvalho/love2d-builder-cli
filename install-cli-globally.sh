#!/bin/bash

set -e

SCRIPT_NAME="love2d-builder"
INSTALL_DIR="${HOME}/.local/bin"
LIB_DIR="${HOME}/.local/lib/love2d-builder"
SOURCE_SCRIPT="love2d-builder-cli.sh"

LIGHT_RED="\033[1;31m"
LIGHT_GREEN="\033[1;32m"
LIGHT_YELLOW="\033[1;33m"
LIGHT_BLUE="\033[1;34m"
WHITE="\033[1;37m"
NC="\033[0m"

print_banner() {
    echo ""
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════╗"
    echo -e "${LIGHT_BLUE}║      ${WHITE}Love2D Builder CLI - Global Installer       ${LIGHT_BLUE}║"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════╝"
    echo ""
}
print_success() {
    echo -e "${LIGHT_GREEN}SUCCESS: $1${NC}"
}

print_error() {
    echo -e "${LIGHT_RED}ERROR: $1${NC}"
}

print_warning() {
    echo -e "${LIGHT_YELLOW}WARNING: $1${NC}"
}

print_info() {
    echo -e "${LIGHT_BLUE}INFO: $1${NC}"
}

main(){
    print_banner

   if [ ! -f "$SOURCE_SCRIPT" ]; then
        print_error "$SOURCE_SCRIPT not found in current directory"
        echo ""
        echo "Please run this script from the love2d-builder-cli directory:"
        echo ""
        echo "  ./install-cli-globally.sh"
        echo ""
        exit 1
    fi

    if [ ! -d "$INSTALL_DIR" ]; then
        print_info "Creating $INSTALL_DIR..."
        mkdir -p "$INSTALL_DIR"
    fi

    print_info "Creating library directory $LIB_DIR..."
    rm -rf "$LIB_DIR"
    mkdir -p "$LIB_DIR"
}
main "$@"