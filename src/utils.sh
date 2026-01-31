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
export BOLD='\033[1m'

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

detect_project_config(){
    detected_name=""
    detected_version=""

    if [ -f "conf.lua" ]; then
        detected_name=$(grep -oP 't\.window\.title\s*=\s*"\K[^"]+' conf.lua 2>/dev/null || true)
        detected_version=$(grep -oP 't\.version\s*=\s*"\K[^"]+' conf.lua 2>/dev/null || true)

        if [ -z "$detected_name" ]; then
            detected_name=$(grep -oP "t\.window\.title\s*=\s*'\K[^']+" conf.lua 2>/dev/null || true)
        fi
        echo "${detected_name}|${detected_version}"
    fi
}


check_love_project() {
    if [ ! -f "main.lua" ] && [ ! -f "conf.lua" ]; then
        print_warning "This doesn't look like a Love2D project"
        print_info "No main.lua or conf.lua found in current directory"
        echo ""
        echo "Options:"
        echo "  1) Create initial setup (main.lua + conf.lua)"
        echo "  2) Exit"
        echo ""
        read -r -p "Choose [1/2]: " response
        case "$response" in
            1)
                create_initial_setup
                return 0
                ;;
            *)
                return 1
                ;;
        esac
    fi
    return 0
}

create_initial_setup() {
    print_header "CREATING INITIAL SETUP"
    
    local game_name
    local folder_name
    folder_name=$(basename "$(pwd)")
    
    read -r -p "Game name [$folder_name]: " game_name
    game_name="${game_name:-$folder_name}"
    
    print_info "Creating conf.lua..."
    cat > conf.lua << EOF
function love.conf(t)
    t.identity = "${game_name}"
    t.version = "11.3"
    t.console = false
    
    t.window.title = "${game_name}"
    t.window.width = 800
    t.window.height = 600
    t.window.resizable = true
    t.window.vsync = 1
    
    t.modules.joystick = true
    t.modules.physics = true
end
EOF
    print_success "Created conf.lua"
    
    print_info "Creating main.lua..."
    cat > main.lua << 'EOF'
_G.love = require("love")
local title = "My Love2D Game"
local message = "Press ESC to exit"

function love.load()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.2)
end

function love.update(dt)
end

function love.draw()
    local w, h = love.graphics.getDimensions()
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(title, 0, h/2 - 50, w, "center")
    
    love.graphics.setColor(0.7, 0.7, 0.7)
    love.graphics.printf(message, 0, h/2 + 20, w, "center")
    
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
EOF
    print_success "Created main.lua"
    
    echo ""
    print_success "Initial setup complete!"
    print_info "Run 'love .' to test your game"
    echo ""
    
    pause_menu
}

check_command(){
    cmd="$1"
    command -v "$cmd" &> /dev/null
}

export -f pause_menu
export -f print_banner_installer
export -f print_banner_cli
export -f print_header

export -f print_success
export -f print_error
export -f print_warning
export -f print_info

export -f detect_project_config

export -f check_love_project
export -f check_command