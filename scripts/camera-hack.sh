#!/usr/bin/env bash
# TERMUX-BLITZ - Camera Hack via SayCheese/CamHack

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/colors.sh"

TOOLS_DIR="$HOME/termux-blitz-tools"

header "📸 CAMERA HACK" $P

echo -e "  ${R}[${Y}1${R}]${N} ${G}SayCheese${N}    ${D}- Camera via phishing link${N}"
echo -e "  ${R}[${Y}2${R}]${N} ${G}CamHack${N}      ${D}- Camera via payload${N}"
echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
echo ""

read -p "$(echo -e ${P}"[${Y}CAM${P}]${N} > ")" ch

case $ch in
    1|saycheese)
        cd "$TOOLS_DIR/saycheese" 2>/dev/null
        bash saycheese.sh
        ;;
    2|camhack)
        cd "$TOOLS_DIR/camhack" 2>/dev/null
        python camhack.py
        ;;
    *)
        exit 0
        ;;
esac
