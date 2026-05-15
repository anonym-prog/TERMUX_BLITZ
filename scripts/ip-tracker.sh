#!/usr/bin/env bash
# TERMUX-BLITZ - IP Tracker

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$SCRIPT_DIR/colors.sh"

TARGET="${1:-$(curl -s ifconfig.me)}"

header "📍 IP TRACKER: $TARGET" $B

echo -e "${C}[${ARROW}]${N} Looking up ${Y}$TARGET${N}..."
echo ""

# Get info from ipinfo.io
data=$(curl -s "ipinfo.io/$TARGET/json" 2>/dev/null)

if [ -z "$data" ]; then
    error "Failed to get IP information"
    exit 1
fi

# Parse and display
ip=$(echo "$data" | grep '"ip"' | cut -d'"' -f4)
city=$(echo "$data" | grep '"city"' | cut -d'"' -f4)
region=$(echo "$data" | grep '"region"' | cut -d'"' -f4)
country=$(echo "$data" | grep '"country"' | cut -d'"' -f4)
loc=$(echo "$data" | grep '"loc"' | cut -d'"' -f4)
org=$(echo "$data" | grep '"org"' | cut -d'"' -f4)
postal=$(echo "$data" | grep '"postal"' | cut -d'"' -f4)
timezone=$(echo "$data" | grep '"timezone"' | cut -d'"' -f4)

echo -e "  ${Y}IP Address:${N}    ${G}$ip${N}"
echo -e "  ${Y}City:${N}          ${G}$city${N}"
echo -e "  ${Y}Region:${N}        ${G}$region${N}"
echo -e "  ${Y}Country:${N}       ${G}$country${N}"
echo -e "  ${Y}Coordinates:${N}   ${G}$loc${N}"
echo -e "  ${Y}ISP/Org:${N}       ${G}$org${N}"
echo -e "  ${Y}Postal:${N}        ${G}$postal${N}"
echo -e "  ${Y}Timezone:${N}      ${G}$timezone${N}"

# Google Maps link
lat=$(echo "$loc" | cut -d',' -f1)
lon=$(echo "$loc" | cut -d',' -f2)
echo ""
echo -e "  ${C}[${ARROW}]${N} ${G}Google Maps:${N} https://www.google.com/maps?q=$lat,$lon"
