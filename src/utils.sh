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
export NC="\033[0m"

print_banner_installer() {
    echo ""
    echo -e "${LIGHT_BLUE}╔══════════════════════════════════════════════════╗"
    echo -e "${LIGHT_BLUE}║      ${WHITE}Love2D Builder CLI - Global Installer       ${LIGHT_BLUE}║"
    echo -e "${LIGHT_BLUE}╚══════════════════════════════════════════════════╝"
    echo ""
}
export -f print_banner_installer

print_success() {
    echo -e "${LIGHT_GREEN}SUCCESS: ${GREEN}$1${NC}"
}
export -f print_success

print_error() {
    echo -e "${LIGHT_RED}ERROR: ${RED}$1${NC}"
}
export -f print_error

print_warning() {
    echo -e "${LIGHT_YELLOW}WARNING: ${YELLOW}$1${NC}"
}
export -f print_warning

print_info() {
    echo -e "${LIGHT_BLUE}INFO: ${BLUE}$1${NC}"
}
export -f print_info