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
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
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

    print_info "Copying CLI files..."
    cp "$SOURCE_SCRIPT" "$LIB_DIR/"
    cp -r src "$LIB_DIR/"
    cp -r scripts "$LIB_DIR/"
    chmod +x "$LIB_DIR/$SOURCE_SCRIPT" "$LIB_DIR"/src/*.sh "$LIB_DIR"/scripts/*.sh
    
    print_info "Installing $SCRIPT_NAME to $INSTALL_DIR..."
    cat > "$INSTALL_DIR/$SCRIPT_NAME" << WRAPPER
    exec "$LIB_DIR/$SOURCE_SCRIPT" "\$@"
WRAPPER
    chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        echo ""
        print_warning "$INSTALL_DIR is not in your PATH"
        echo ""
        echo "Add this line to your ~/.bashrc or ~/.zshrc:"
        echo ""
        echo -e "    ${GREEN}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
        echo ""
        echo "Then run:"
        echo ""
        echo -e "    ${GREEN}source ~/.bashrc${NC}  # or source ~/.zshrc"
        echo ""
    fi

    echo ""
    print_success "Installation complete!"
    echo ""
    echo "Usage:"
    echo ""
    echo -e "    ${GREEN}$SCRIPT_NAME${NC}           # Run interactive menu"
    echo -e "    ${GREEN}$SCRIPT_NAME --help${NC}    # Show help"
    echo -e "    ${GREEN}$SCRIPT_NAME --version${NC} # Show version"
    echo ""
}

main "$@"