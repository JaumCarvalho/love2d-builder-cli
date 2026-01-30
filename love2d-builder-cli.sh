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

test_game(){
    echo "test game function"
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
        echo "3) Show Info"
        echo ""
        echo "0) Exit"
        echo ""
        read -r -p "Option: " choice
        case $choice in
            1) do_build_linux; pause_menu ;;
            2) test_game; pause_menu ;;
            3) collect_info; pause_menu ;;
            0|q|Q) echo ""; echo -e "${GREEN}Goodbye!"; exit 0 ;;
            *) print_error "Invalid option"; sleep 1 ;;
        esac
    done
}



main() {
    print_menu_cli
}

main "$@"