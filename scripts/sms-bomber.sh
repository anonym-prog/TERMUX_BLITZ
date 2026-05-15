#!/usr/bin/env bash
# TERMUX-BLITZ - SMS Bomber

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/colors.sh"

TOOLS_DIR="$HOME/termux-blitz-tools"

header "💬 SMS BOMBER" $P

echo -e "  ${R}[${Y}1${R}]${N} ${G}TBomb${N}    ${D}- Multi-API SMS bomber${N}"
echo -e "  ${R}[${Y}2${R}]${N} ${G}SpamX${N}    ${D}- Layer SMS bomber${N}"
echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
echo ""

read -p "$(echo -e ${P}"[${Y}BOMB${P}]${N} > ")" ch

case $ch in
    1|tbomb)
        cd "$TOOLS_DIR/tbomb" 2>/dev/null
        bash TBomb.sh
        ;;
    2|spamx)
        cd "$TOOLS_DIR/spamx" 2>/dev/null
        python spamx.py
        ;;
    *)
        exit 0
        ;;
esac
