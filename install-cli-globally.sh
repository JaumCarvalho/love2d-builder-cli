#!/bin/bash

set -e

SCRIPT_NAME="love2d-builder"
INSTALL_DIR="${HOME}/.local/bin"
LIB_DIR="${HOME}/.local/lib/love2d-builder"
SOURCE_SCRIPT="love2d-builder-cli.sh"

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
LIGHT_BLUE="\033[1;34m"
WHITE="\033[0m"

print_banner() {
    echo ""
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════╗"
    echo -e "${LIGHT_BLUE}║      ${WHITE}Love2D Builder CLI - Global Installer       ${LIGHT_BLUE}║"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════╝"
    echo ""
}

print_banner