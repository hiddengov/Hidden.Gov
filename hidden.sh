#!/bin/bash

# Hidden.Gov - Portable Pentesting Toolkit for Windows (via Git Bash)
# This script downloads and runs REAL, portable tools.

# --- Color Codes ---
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Configuration ---
HG_DIR="/c/HiddenGov"
TOOLS_DIR="\${HG_DIR}/Tools"

# --- Helper Functions ---
print_status() {
    echo -e "${GREEN}[+]${NC} \$1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} \$1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} \$1"
}

# --- Main Setup Logic ---
main() {
    clear
    echo -e "${GREEN}==================================================${NC}"
    echo -e "\${GREEN}     H I D D E N . G O V - Portable Toolkit\${NC}"
    echo -e "${GREEN}==================================================${NC}"
    echo

    # Check if running on Windows
    if [[ "$OSTYPE" != "msys" && "$OSTYPE" != "cygwin" ]]; then
        print_error "This script is designed for Windows (Git Bash/MSYS)."
        exit 1
    fi

    print_status "Setting up workspace in \${HG_DIR}..."

    # Create directories if they don't exist
    # Use 'cmd //c mkdir' to leverage Windows permissions if needed
    if [ ! -d "\$HG_DIR" ]; then
        print_status "Creating directory: \${HG_DIR}"
        cmd //c mkdir "$HG_DIR" 2>/dev/null || mkdir -p "$HG_DIR"
    fi
    if [ ! -d "\$TOOLS_DIR" ]; then
        print_status "Creating directory: \${TOOLS_DIR}"
        cmd //c mkdir "$TOOLS_DIR" 2>/dev/null || mkdir -p "$TOOLS_DIR"
    fi

    cd "\$TOOLS_DIR" || { print_error "Failed to enter tools directory. Exiting."; exit 1; }

    # --- Download Tools ---
    print_status "Checking for required tools..."

    # Nmap
    if [ ! -f "nmap.exe" ]; then
        print_status "Downloading Nmap..."
        curl -L -k -o "nmap.zip" "https://nmap.org/dist/nmap-7.95-win32.zip"
        if [ -f "nmap.zip" ]; then
            print_status "Extracting Nmap..."
            tar -xf "nmap.zip"
            mv "nmap-7.95/nmap.exe" . 2>/dev/null
            mv "nmap-7.95/npcap-win-1.0.dll" . 2>/dev/null
            rm -rf "nmap-7.95" "nmap.zip"
            print_status "Nmap downloaded successfully."
        else
            print_error "Failed to download Nmap."
        fi
    else
        print_status "Nmap already exists. Skipping download."
    fi

    # Hydra
    if [ ! -f "hydra.exe" ]; then
        print_status "Downloading Hydra..."
        curl -L -k -o "hydra.zip" "https://github.com/vanhauser-thc/thc-hydra/releases/download/v9.5/hydra-9.5-win.zip"
        if [ -f "hydra.zip" ]; then
            print_status "Extracting Hydra..."
            tar -xf "hydra.zip"
            mv "hydra-9.5-win/hydra.exe" . 2>/dev/null
            rm -rf "hydra-9.5-win" "hydra.zip"
            print_status "Hydra downloaded successfully."
        else
            print_error "Failed to download Hydra."
        fi
    else
        print_status "Hydra already exists. Skipping download."
    fi

    # John the Ripper
    if [ ! -f "john.exe" ]; then
        print_status "Downloading John the Ripper..."
        curl -L -k -o "john.zip" "https://www.openwall.com/john/k/john-1.9.0-jumbo-1-win64.zip"
        if [ -f "john.zip" ]; then
            print_status "Extracting John the Ripper..."
            tar -xf "john.zip"
            mv "john-1.9.0-jumbo-1-win64/run/john.exe" . 2>/dev/null
            mv "john-1.9.0-jumbo-1-win64/run/"*.chr . 2>/dev/null
            rm -rf "john-1.9.0-jumbo-1-win64" "john.zip"
            print_status "John the Ripper downloaded successfully."
        else
            print_error "Failed to download John the Ripper."
        fi
    else
        print_status "John the Ripper already exists. Skipping download."
    fi

    # SQLMap
    if [ ! -f "sqlmap.py" ]; then
        print_status "Downloading SQLMap..."
        curl -L -k -o "sqlmap.zip" "https://github.com/sqlmapproject/sqlmap/archive/refs/heads/master.zip"
        if [ -f "sqlmap.zip" ]; then
            print_status "Extracting SQLMap..."
            tar -xf "sqlmap.zip"
            mv "sqlmap-master/sqlmap.py" . 2>/dev/null
            rm -rf "sqlmap-master" "sqlmap.zip"
            print_status "SQLMap downloaded successfully."
        else
            print_error "Failed to download SQLMap."
        fi
    else
        print_status "SQLMap already exists. Skipping download."
    fi

    # Crunch
    if [ ! -f "crunch.exe" ]; then
        print_status "Downloading Crunch..."
        curl -L -k -o "crunch.zip" "https://sourceforge.net/projects/crunch-wordlist/files/crunch-wordlist/crunch-3.6.zip/download"
        if [ -f "crunch.zip" ]; then
            print_status "Extracting Crunch..."
            tar -xf "crunch.zip"
            mv "crunch-3.6/crunch.exe" . 2>/dev/null
            rm -rf "crunch-3.6" "crunch.zip"
            print_status "Crunch downloaded successfully."
        else
            print_error "Failed to download Crunch."
        fi
    else
        print_status "Crunch already exists. Skipping download."
    fi
    
    echo
    print_status "Tool setup complete."
    read -p "Press Enter to launch the main menu..."
    main_menu
}

# --- Main Menu Loop ---
main_menu() {
    while true; do
        clear
        echo -e "${GREEN}==================================================${NC}"
        echo -e "\${GREEN}     H I D D E N . G O V - Portable Toolkit\${NC}"
        echo -e "${GREEN}==================================================${NC}"
        echo -e "Tools Directory: \${TOOLS_DIR}"
        echo
        echo " [01] >> Information Gathering:     - Nmap Scan"
        echo " [02] >> Exploitation Tools:        - (Requires Metasploit - Not Portable)"
        echo " [03] >> Sniffing and Spoofing:     - (Requires Wireshark - Not Portable)"
        echo " [04] >> Web Attack Tools:          - SQLMap"
        echo " [05] >> Cam Hacking Tools:         - (Requires specialized tools - Not Portable)"
        echo " [06] >> Remote Trojan RAT:         - (Requires Metasploit - Not Portable)"
        echo " [07] >> SQL Injection Tools:       - SQLMap"
        echo " [08] >> SocialMedia Hacking:       - (Requires SET - Not Portable)"
        echo " [09] >> SMS spamming Tools:        - (Requires API/Service - Not Portable)"
        echo " [10] >> Vulnerability Analysis:    - Nmap Script Scan"
        echo " [11] >> DarkSearch Tool:           - (Requires Tor Browser - Not Portable)"
        echo " [12] >> Phishing And IpHack:       - (Requires SET - Not Portable)"
        echo " [13] >> Password Attack:           - Hydra (SSH) / John the Ripper"
        echo " [14
