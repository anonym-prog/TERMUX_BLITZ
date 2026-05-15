#!/usr/bin/env bash
# TERMUX-BLITZ - Quick Setup

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║        ⚡ TERMUX-BLITZ - Quick Setup ⚡                 ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Update
echo "[→] Updating Termux..."
apt update -y && apt upgrade -y

# Dependencies
echo "[→] Installing dependencies..."
apt install -y git python python2 curl wget php openssl-tool termux-api proot

# Clone & install
if [ -d "TERMUX-BLITZ" ]; then
    cd TERMUX-BLITZ
else
    echo "[→] You're already in TERMUX-BLITZ directory"
fi

chmod +x install.sh blitz.sh modules/*.sh scripts/*.sh 2>/dev/null
echo "[→] Running installer..."
./install.sh
