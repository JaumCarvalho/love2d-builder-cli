#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$ROOT_DIR/src/utils.sh"

PROJECT_DIR="${1:-$(pwd)}"
GAME_NAME="${GAME_NAME:-my-game}"
BUILD_DIR="${BUILD_DIR:-builds}"
OUTPUT_DIR="${BUILD_DIR}/linux"
