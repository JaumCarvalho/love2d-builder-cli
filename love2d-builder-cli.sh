#!/bin/bash

set -e

readonly SCRIPT_VERSION="1.0"
readonly SCRIPT_NAME="Love2D Builder CLI"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"
source "$SCRIPT_DIR/src/utils.sh"

GAME_NAME=""
GAME_VERSION="1.0"
PACKAGE_NAME=""
LOVE_VERSION="11.3"
AUTHOR_NAME="${USER:-developer}"
BUILD_DIR="builds"

print_banner_cli() {
    clear
    echo -e
    echo "╔═══════════════════════════════════════════════════════╗"
    echo "║                                                       ║"
    echo "║                  LÖVE2D Builder CLI                   ║"
    echo "║                                                       ║"
    echo "╚═══════════════════════════════════════════════════════╝"
    echo -e
    echo -e "${BLUE}Version: ${SCRIPT_VERSION}${NC}"
    echo ""
}

print_banner_cli