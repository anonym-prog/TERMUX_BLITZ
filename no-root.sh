#!/usr/bin/env bash
# TERMUX-BLITZ - Non-Root Tools Installer
# Safe to run without root

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/colors.sh"

header "✅ NON-ROOT TOOLS INSTALLER" $G

TOOLS_DIR="$HOME/termux-blitz-tools"
mkdir -p "$TOOLS_DIR"

tools=(
    "Zphisher:https://github.com/htr-tech/zphisher.git"
    "SayCheese:https://github.com/hackerxphantom/saycheese.git"
    "CamHack:https://github.com/noob-hackers/camhack.git"
    "IPGeo:https://github.com/noob-hackers/ipgeo.git"
    "TBomb:https://github.com/TheSpeedX/TBomb.git"
    "Cupp:https://github.com/Mebus/cupp.git"
    "HashBuster:https://github.com/UltimateHackers/Hash-Buster.git"
    "RED_HAWK:https://github.com/Tuhinshubhra/RED_HAWK.git"
    "OSIF:https://github.com/ciku370/OSIF.git"
)

total=${#tools[@]}
count=0

for tool in "${tools[@]}"; do
    count=$((count + 1))
    name="${tool%%:*}"
    repo="${tool##*:}"
    
    echo -ne "${Y}[${count}/${total}]${N} Installing ${G}${name}${N}... "
    
    if [ -d "$TOOLS_DIR/$(echo "$name" | tr 'A-Z' 'a-z')" ]; then
        echo -e "${G}[${CHECK}]${N} ${D}already installed${N}"
    else
        git clone --depth 1 "$repo" "$TOOLS_DIR/$(echo "$name" | tr 'A-Z' 'a-z')" 2>/dev/null && \
            echo -e "${G}[${CHECK}]${N}" || \
            echo -e "${R}[${CROSS}]${N}"
    fi
done

success "All non-root tools installed!"
echo ""
echo -e "${Y}Run 'blitz' to access all tools${N}"
