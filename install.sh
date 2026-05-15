#!/usr/bin/env bash
# TERMUX-BLITZ - Main Installer

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/colors.sh"

trap 'echo -e "\n${R}[${CROSS}] Installation interrupted!${N}"; exit 1' SIGINT SIGTERM

clear
cat "$SCRIPT_DIR/.banner.txt" 2>/dev/null || true
header "TERMUX-BLITZ INSTALLER v1.0"

# Check Termux
if [ ! -d "/data/data/com.termux" ] && [ ! -d "/data/data/com.termux.fdroid" ]; then
    warning "This installer is designed for Termux on Android"
    confirm "Continue anyway?" || exit 1
fi

# ============================================
# UPDATE & BASE DEPS
# ============================================
header "UPDATING TERMUX & INSTALLING BASE"

info "Updating packages..."
apt update -y && apt upgrade -y
success "Packages updated!"

info "Installing base dependencies..."
apt install -y git python python2 curl wget grep openssl-tool php termux-api proot proot-distro
success "Base dependencies installed!"

# ============================================
# STORAGE ACCESS
# ============================================
header "STORAGE ACCESS"
if [ ! -d "$HOME/storage" ]; then
    info "Granting storage access..."
    termux-setup-storage
    sleep 2
    success "Storage access granted!"
else
    info "Storage already accessible"
fi

# ============================================
# CHECK ROOT
# ============================================
header "ROOT CHECK"
if check_root; then
    success "Running with root privileges"
    HAS_ROOT=true
else
    info "Running without root (non-root mode)"
    warning "WiFi tools (Wifite, Airgeddon) will be skipped"
    HAS_ROOT=false
fi

# ============================================
# INSTALL DIRECTORY
# ============================================
header "SETTING UP DIRECTORIES"

TOOLS_DIR="$HOME/termux-blitz-tools"
mkdir -p "$TOOLS_DIR"
mkdir -p "$HOME/termux-blitz/reports"
mkdir -p "$HOME/termux-blitz/wordlists"
success "Directories created at $TOOLS_DIR"

# ============================================
# INSTALL TOOLS
# ============================================
header "INSTALLING 20 TOOLS"

cd "$TOOLS_DIR"

install_tool() {
    local name="$1"
    local repo="$2"
    local dir="$3"
    
    echo -ne "${C}[${ARROW}]${N} Installing ${Y}${name}${N}... "
    
    if [ -d "$dir" ]; then
        echo -e "${G}[${CHECK}]${N} ${D}already installed${N}"
        return
    fi
    
    git clone --depth 1 "$repo" "$dir" 2>/dev/null && {
        # Install Python dependencies if requirements.txt exists
        [ -f "$dir/requirements.txt" ] && pip install -r "$dir/requirements.txt" 2>/dev/null >/dev/null
        [ -f "$dir/requirements.txt" ] && pip2 install -r "$dir/requirements.txt" 2>/dev/null >/dev/null
        chmod +x "$dir"/*.sh "$dir"/*.py 2>/dev/null
        echo -e "${G}[${CHECK}]${N}"
    } || {
        echo -e "${R}[${CROSS}]${N}"
    }
}

# 01. Zphisher
install_tool "Zphisher" "https://github.com/htr-tech/zphisher.git" "zphisher"

# 02. SayCheese
install_tool "SayCheese" "https://github.com/hackerxphantom/saycheese.git" "saycheese"

# 03. CamHack
install_tool "CamHack" "https://github.com/noob-hackers/camhack.git" "camhack"

# 04. IPGeo
install_tool "IPGeo" "https://github.com/noob-hackers/ipgeo.git" "ipgeo"

# 05. SocialSploit
install_tool "SocialSploit" "https://github.com/CrackerDuo/SocialSploit.git" "socialsploit"

# 06. InstaHack
install_tool "InstaHack" "https://github.com/evildevill/instahack.git" "instahack"

# 07. TBomb
install_tool "TBomb" "https://github.com/TheSpeedX/TBomb.git" "tbomb"

# 08. SpamX
install_tool "SpamX" "https://github.com/Evildevill/SpamX.git" "spamx"

# 09. HiddenEye
install_tool "HiddenEye" "https://github.com/DarkSecDevelopers/HiddenEye.git" "hiddeneye"

# 10. Nexphisher
install_tool "Nexphisher" "https://github.com/htr-tech/nexphisher.git" "nexphisher"

# 11. Cupp
install_tool "Cupp" "https://github.com/Mebus/cupp.git" "cupp"

# 12. HashBuster
install_tool "HashBuster" "https://github.com/UltimateHackers/Hash-Buster.git" "hashbuster"

# 13. Lazymux
install_tool "Lazymux" "https://github.com/DarknessCyber/Lazymux.git" "lazymux"

# 14. OSIF
install_tool "OSIF" "https://github.com/ciku370/OSIF.git" "osif"

# 15. RED_HAWK
install_tool "RED_HAWK" "https://github.com/Tuhinshubhra/RED_HAWK.git" "red_hawk"

# 16. Webkiller
install_tool "Webkiller" "https://github.com/ultrasecurity/webkiller.git" "webkiller"

# 17. RouterSploit
install_tool "RouterSploit" "https://github.com/threat9/routersploit.git" "routersploit"
pip install -r routersploit/requirements.txt 2>/dev/null >/dev/null

# 18. Rucky
install_tool "Rucky" "https://github.com/mayankchugh-learning/rucky.git" "rucky"

# Root only tools
if [ "$HAS_ROOT" = true ]; then
    # 19. Wifite
    install_tool "Wifite" "https://github.com/derv82/wifite2.git" "wifite"
    
    # 20. Airgeddon
    install_tool "Airgeddon" "https://github.com/v1s1t0r1sh3r3/airgeddon.git" "airgeddon"
else
    info "Skipping WiFi tools (root required)"
    warning "Wifite & Airgeddon not installed"
fi

success "All tools installed!"

# ============================================
# COPY WORDLIST
# ============================================
header "WORDLISTS"
cp "$SCRIPT_DIR/wordlists/common.txt" "$HOME/termux-blitz/wordlists/" 2>/dev/null || true
success "Wordlists copied!"

# ============================================
# INSTALL LAUNCHER
# ============================================
header "INSTALLING LAUNCHER"

cp "$SCRIPT_DIR/blitz.sh" "$PREFIX/bin/blitz"
chmod +x "$PREFIX/bin/blitz"
success "Launcher installed! Type 'blitz' to start"

# ============================================
# FINAL
# ============================================
clear
echo -e "${G}"
echo "████████████████████████████████████████████████████████████████"
echo "██                                                            ██"
echo "██  ████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗    ██"
echo "██  ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║   ██║╚██╗██╔╝    ██"
echo "██     ██║   █████╗  ██████╔╝██╔████╔██║██║   ██║ ╚███╔╝     ██"
echo "██     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║   ██║ ██╔██╗     ██"
echo "██     ██║   ███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗    ██"
echo "██     ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝    ██"
echo "██                                                            ██"
echo "██              ╔══════════════════════════════╗              ██"
echo "██              ║   INSTALLATION COMPLETE!    ║              ██"
echo "██              ╚══════════════════════════════╝              ██"
echo "██                                                            ██"
echo "██  ${Y}20 Tools installed successfully!${N}                    ██"
echo "██                                                            ██"
echo "██  ${G}📁 Tools location:${N} $TOOLS_DIR           ██"
echo "██  ${G}📁 Reports:${N}       ~/termux-blitz/reports/       ██"
echo "██                                                            ██"
echo "██  ${Y}⚡ Launch:${N} blitz                                  ██"
echo "██                                                            ██"
echo -e "██  ${R}☠ AUTHORIZED PENTESTING ONLY ${N}                       ██"
echo "██                                                            ██"
echo "████████████████████████████████████████████████████████████████"
echo -e "${N}"
echo ""
echo -e "  ${Y}Run 'blitz' to start the interactive menu${N}"
echo ""
