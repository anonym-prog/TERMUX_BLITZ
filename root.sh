#!/usr/bin/env bash
# TERMUX-BLITZ - Root Tools Installer
# Only run if you have root access

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/colors.sh"

if [ "$(id -u)" -ne 0 ]; then
    error "Root access required!"
    echo "Run with: sudo bash root.sh"
    exit 1
fi

header "📡 ROOT TOOLS INSTALLER" $Y

TOOLS_DIR="$HOME/termux-blitz-tools"
mkdir -p "$TOOLS_DIR"

# Install Wifite
echo -e "${C}[${ARROW}]${N} Installing ${Y}Wifite${N} (WiFi auditor)..."
if [ -d "$TOOLS_DIR/wifite" ]; then
    echo -e "  ${G}[${CHECK}]${N} Already installed"
else
    git clone --depth 1 https://github.com/derv82/wifite2.git "$TOOLS_DIR/wifite" 2>/dev/null
    pip install -r "$TOOLS_DIR/wifite/requirements.txt" 2>/dev/null >/dev/null
    echo -e "  ${G}[${CHECK}]${N} Wifite installed"
fi

# Install Airgeddon
echo -e "${C}[${ARROW}]${N} Installing ${Y}Airgeddon${N} (WiFi all-in-one)..."
if [ -d "$TOOLS_DIR/airgeddon" ]; then
    echo -e "  ${G}[${CHECK}]${N} Already installed"
else
    git clone --depth 1 https://github.com/v1s1t0r1sh3r3/airgeddon.git "$TOOLS_DIR/airgeddon" 2>/dev/null
    chmod +x "$TOOLS_DIR/airgeddon/airgeddon.sh"
    echo -e "  ${G}[${CHECK}]${N} Airgeddon installed"
fi

success "Root tools installed!"
echo ""
echo -e "${Y}Access via: blitz wifi${N}"
