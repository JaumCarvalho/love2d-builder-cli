#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$ROOT_DIR/src/utils.sh"

PROJECT_DIR="${1:-$(pwd)}"
GAME_NAME="${GAME_NAME:-my-game}"
BUILD_DIR="${BUILD_DIR:-builds}"
OUTPUT_DIR="${BUILD_DIR}/linux"

build_linux(){
    print_header "BUILDING FOR LINUX"
    cd "$PROJECT_DIR" || exit 1

    if [ "$GAME_NAME" = "my-game" ] && [ -f "conf.lua" ]; then
        detected=$(detect_project_config 2>/dev/null || echo "|")
        detecded_name=$(echo "$detected" |  cut -d'|' -f1)
        if [ -n "$detected_name" ]; then
            GAME_NAME="$detected_name"
            print_info "Detected game name: $GAME_NAME"
        fi
    fi

    if [ ! -f "main.lua" ]; then
        print_warning "main.lua not found in $PROJECT_DIR"
    fi

    if [ ! -f "conf.lua" ]; then
        print_warning "conf.lua not found in $PROJECT_DIR"
    fi

    if ! command -v zip &> /dev/null; then
        print_error "zip command not found. Install it with: sudo apt install zip"
        return 1
    fi

    love_file="${GAME_NAME}.love"

    print_info "Creating build directory: $OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
    print_info "Creating $love_file..."
}