---

### 2️⃣ **`colors.sh`**

```bash
#!/usr/bin/env bash
# TERMUX-BLITZ - Color Configuration

# Colors
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
P='\033[1;35m'
C='\033[1;36m'
W='\033[1;37m'
N='\033[0m'
D='\033[2m'
BD='\033[1m'

# Icons
CHECK="${G}✓${N}"
CROSS="${R}✗${N}"
WARN="${Y}⚠${N}"
ARROW="${C}→${N}"
BOLT="${Y}⚡${N}"
ANDROID="${G}🤖${N}"

# Functions
header() {
    local title="$1"
    local color="${2:-$R}"
    echo ""
    echo -e "${color}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${color}║${N}  ${Y}${BD}◆${N} ${W}${BD}${title}${N} ${Y}${BD}◆${N}"
    echo -e "${color}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
}

success() { echo -e " ${G}[${CHECK}]${N} ${1}"; }
error() { echo -e " ${R}[${CROSS}]${N} ${1}"; }
warning() { echo -e " ${Y}[${WARN}]${N} ${1}"; }
info() { echo -e " ${C}[${ARROW}]${N} ${1}"; }

tool_banner() {
    local name="$1"
    local category="$2"
    local color="${3:-$R}"
    echo ""
    echo -e "${color}╔══════════════════════════════════════════════════════════╗${N}"
    echo -e "${color}║${N} ${Y}${BOLT}${N} ${W}${BD}${name}${N} ${D}(${category})${N}"
    echo -e "${color}╚══════════════════════════════════════════════════════════╝${N}"
    echo ""
}

confirm() {
    local prompt="$1"
    local yn
    read -p "$(echo -e ${Y}"[?] ${prompt} [y/N]: "${N})" yn
    case "$yn" in [Yy]*) return 0 ;; *) return 1 ;; esac
}

check_root() {
    if [ "$(id -u)" -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

export R G Y B P C W N D BD CHECK CROSS WARN ARROW BOLT ANDROID
