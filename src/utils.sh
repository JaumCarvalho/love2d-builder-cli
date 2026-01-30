#!/bin/bash

export LIGHT_RED="\033[1;31m"
export LIGHT_GREEN="\033[1;32m"
export LIGHT_YELLOW="\033[1;33m"
export LIGHT_BLUE="\033[1;34m"
export RED="\033[0;31m"
export GREEN="\033[0;32m"
export YELLOW="\033[0;33m"
export BLUE="\033[0;34m"
export WHITE="\033[1;37m"
export MAGENTA='\033[0;35m'
export CYAN='\033[0;36m'
export NC="\033[0m"

pause_menu() {
    echo ""
    echo -e "${YELLOW}Press ENTER to continue...${NC}"
    read -r
}

print_banner_installer() {
    echo ""
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════╗"
    echo -e "${LIGHT_BLUE}║      ${WHITE}Love2D Builder CLI - Global Installer       ${LIGHT_BLUE}║"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════╝"
    echo ""
}

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
print_header() {
    local title="$1"
    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════${NC}"
    echo -e "${BOLD}${title}${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════${NC}"
    echo ""
}

print_success() {
    echo -e "${LIGHT_GREEN}SUCCESS: ${GREEN}$1${NC}"
}

print_error() {
    echo -e "${LIGHT_RED}ERROR: ${RED}$1${NC}"
}

print_warning() {
    echo -e "${LIGHT_YELLOW}WARNING: ${YELLOW}$1${NC}"
}

print_info() {
    echo -e "${LIGHT_BLUE}INFO: ${BLUE}$1${NC}"
}
export -f pause_menu
export -f print_banner_installer
export -f print_banner_cli
export -f print_header

export -f print_success
export -f print_error
export -f print_warning
export -f print_info