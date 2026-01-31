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

do_build_linux(){
    echo "do build linux function"
}

test_game() {
    print_header "TESTING GAME"
    
    if ! check_command "love"; then
        print_error "LÖVE not found. Install from https://love2d.org"
        return 1
    fi
    
    print_info "Starting LÖVE..."
    love .
}

collect_info() {
    print_header "PROJECT CONFIGURATION"
    detected=$(detect_project_config)
    detected_name=$(echo "$detected" | cut -d'|' -f1)
    detected_version=$(echo "$detected" | cut -d'|' -f2)

    if [ -n "$detected_name" ]; then
    print_success "Detected: $detecded_name"
    read -r -p "Game name [$detected_name]: " input
    GAME_NAME="${input:-$detected_name}"
    else
        read -r -p "Game name [my-game]: " input
        GAME_NAME="${input:-my-game}"
    fi

    default_ver="${detected_version:-$GAME_VERSION}"
    read -r -p "Version [$default_ver]: " input
    GAME_VERSION="${input:-$default_ver}"

    default_pkg="com.${AUTHOR_NAME,,}.${GAME_NAME//[^a-zA-Z0-9]/_}"
    read -r -p "Package [$default_pkg]: " input
    PACKAGE_NAME="${input:-$default_pkg}"

    read -r -p "LÖVE version [$LOVE_VERSION]: " input
    LOVE_VERSION="${input:-$LOVE_VERSION}"

    read -r -p "Author [$AUTHOR_NAME]: " input
    AUTHOR_NAME="${input:-$AUTHOR_NAME}"

    export GAME_NAME GAME_VERSION PACKAGE_NAME LOVE_VERSION AUTHOR_NAME BUILD_DIR

    echo ""
    print_success "Configuration saved!"
}

show_info() {
    print_header "PROJECT INFO"
    
    echo -e "${BOLD}Name:${NC}     $GAME_NAME"
    echo -e "${BOLD}Version:${NC}  $GAME_VERSION"
    echo -e "${BOLD}Package:${NC}  $PACKAGE_NAME"
    echo -e "${BOLD}LÖVE:${NC}     $LOVE_VERSION"
    echo -e "${BOLD}Author:${NC}   $AUTHOR_NAME"
    echo ""
    echo -e "${BOLD}Directory:${NC} $(pwd)"
    echo ""
    [ -f "conf.lua" ] && echo -e "  conf.lua: ${GREEN}✅${NC}" || echo -e "  conf.lua: ${RED}❌${NC}"
    [ -f "main.lua" ] && echo -e "  main.lua: ${GREEN}✅${NC}" || echo -e "  main.lua: ${RED}❌${NC}"
}

print_menu_cli(){
    while true; do
        print_banner_cli
        [ -n "$GAME_NAME" ] && echo -e "Project: ${GAME_NAME} v${GAME_VERSION}${NC}"
        echo -e "${MAGENTA}Build:${NC}"
        echo "1) Linux"
        echo ""
        echo -e "${MAGENTA}Tools:${NC}"
        echo "2) Test Game"
        echo ""
        echo -e "${MAGENTA}Config:${NC}"
        echo "3) Configure"
        echo "4) Show Info"
        echo ""
        echo "0) Exit"
        echo ""
        read -r -p "Option: " choice
        case $choice in
            1) do_build_linux; pause_menu ;;
            2) test_game; pause_menu ;;
            3) collect_info; pause_menu ;;
            4) [ -z "$GAME_NAME" ] && collect_info; show_info; pause_menu ;;
            0|q|Q) echo ""; echo -e "${GREEN}Goodbye!"; exit 0 ;;
            *) print_error "Invalid option"; sleep 1 ;;
        esac
    done
}


show_help() {
    cat << EOF
$SCRIPT_NAME v$SCRIPT_VERSION

Usage: $(basename "$0") [OPTIONS]

Options:
  --help, -h       Show this help
  --version, -v    Show version

Without options, runs interactive menu.

Examples:
  $(basename "$0")              # Interactive menu
  $(basename "$0") --help       # Show help

Docs: https://github.com/jaumcarvalho/love2d-builder-cli
EOF
}

show_version() {
    echo "$SCRIPT_NAME v$SCRIPT_VERSION"
}

main() {
    case "${1:-}" in
        --help|-h) show_help; exit 0 ;;
        --version|-v) show_version; exit 0 ;;
        "") check_love_project || exit 1; print_menu_cli ;;
        *) print_error "Unknown: $1"; echo "Try --help"; exit 1 ;;
    esac
}

main "$@"