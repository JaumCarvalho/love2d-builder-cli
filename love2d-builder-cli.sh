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

print_menu_cli(){
    while true; do
        print_banner_cli
        [ -n "$GAME_NAME" ] && echo -e "Project: ${GAME_NAME} v${GAME_VERSION}${NC}"
        echo -e "${MAGENTA}Build:${NC}"
        echo "1) Linux"
        echo "0) Exit"
        read -r -p "Option: " choice
        case $choice in
            1) do_build_linux; pause_menu ;;
            0|q|Q) echo ""; echo -e "${GREEN}Goodbye!"; exit 0 ;;
            *) print_error "Invalid option"; sleep 1 ;;
        esac
    done
}



main() {
    print_menu_cli
}

main "$@"