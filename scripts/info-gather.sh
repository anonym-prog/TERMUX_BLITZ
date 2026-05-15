#!/usr/bin/env bash
# TERMUX-BLITZ - Information Gathering

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/colors.sh"

header "ℹ️  DEVICE & NETWORK INFO" $C

echo -e "${C}═════════════════════════════════════════════${N}"
echo -e "${Y}  DEVICE INFORMATION${N}"
echo -e "${C}═════════════════════════════════════════════${N}"
echo ""
echo -e "  ${G}Android:${N}     $(getprop ro.build.version.release 2>/dev/null || echo 'N/A')"
echo -e "  ${G}SDK:${N}         $(getprop ro.build.version.sdk 2>/dev/null || echo 'N/A')"
echo -e "  ${G}Device:${N}      $(getprop ro.product.model 2>/dev/null || echo 'N/A')"
echo -e "  ${G}Brand:${N}       $(getprop ro.product.brand 2>/dev/null || echo 'N/A')"
echo -e "  ${G}Manufacturer:${N} $(getprop ro.product.manufacturer 2>/dev/null || echo 'N/A')"
echo -e "  ${G}Kernel:${N}      $(uname -r)"
echo -e "  ${G}Arch:${N}        $(uname -m)"
echo ""

echo -e "${C}═════════════════════════════════════════════${N}"
echo -e "${Y}  NETWORK INFORMATION${N}"
echo -e "${C}═════════════════════════════════════════════${N}"
echo ""
echo -e "  ${G}Public IP:${N}   $(curl -s ifconfig.me 2>/dev/null || echo 'Offline')"
echo -e "  ${G}Local IP:${N}    $(ifconfig 2>/dev/null | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -1 | sed 's/inet //;s/addr://' || echo 'N/A')"
echo -e "  ${G}Gateway:${N}     $(ip route | grep default | awk '{print $3}' 2>/dev/null || echo 'N/A')"
echo -e "  ${G}DNS:${N}         $(getprop net.dns1 2>/dev/null || echo 'N/A')"
echo ""

echo -e "${C}═════════════════════════════════════════════${N}"
echo -e "${Y}  STORAGE${N}"
echo -e "${C}═════════════════════════════════════════════${N}"
echo ""
echo -e "  ${G}Internal:${N}    $(df -h /data 2>/dev/null | tail -1 | awk '{print $3 " / " $2}' || echo 'N/A')"
echo -e "  ${G}External:${N}    $(df -h /sdcard 2>/dev/null | tail -1 | awk '{print $3 " / " $2}' || echo 'N/A')"
echo ""

echo -e "${C}═════════════════════════════════════════════${N}"
echo -e "${Y}  INSTALLED TOOLS${N}"
echo -e "${C}═════════════════════════════════════════════${N}"
echo ""
TOOLS_DIR="$HOME/termux-blitz-tools"
for tool in "$TOOLS_DIR"/*/; do
    name=$(basename "$tool")
    echo -e "  ${G}→${N} ${Y}$name${N}"
done
