@echo off
setlocal enabledelayedexpansion
:: Hidden.Gov - Real Pentesting Framework for Windows
:: This script sets up WSL and installs real tools. RUN AS ADMIN.

title Hidden.Gov - System Setup
color 0A

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] This script requires Administrator privileges.
    echo Please right-click the script and select "Run as administrator".
    pause
    exit /b
)

:MAIN_MENU
cls
echo.
echo  ==================================================
echo  H I D D E N . G O V - System Setup
echo  ==================================================
echo  STATUS: Checking Environment...
echo.
echo  [1] Check WSL Status
echo  [2] Install WSL & Ubuntu (Recommended First Step)
echo  [3] Install Pentesting Tools into Ubuntu
echo  [4] Launch Hidden.Gov (Main Interface)
echo  [5] Exit
echo.
set /p choice="Enter option number: "

if "%choice%"=="1" goto CHECK_WSL
if "%choice%"=="2" goto INSTALL_WSL
if "%choice%"=="3" goto INSTALL_TOOLS
if "%choice%"=="4" goto LAUNCH_HG
if "%choice%"=="5" exit /b
goto MAIN_MENU

:CHECK_WSL
cls
echo [+] Checking WSL status...
wsl --list --verbose
echo.
pause
goto MAIN_MENU

:INSTALL_WSL
cls
echo [+] This will install WSL and the latest Ubuntu.
echo [+] This may require a reboot.
echo.
set /p confirm="Proceed? (y/n): "
if /i "!confirm!" neq "y" goto MAIN_MENU

echo [+] Enabling WSL feature...
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
echo [+] Enabling Virtual Machine Platform...
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
echo.
echo [!] WSL features enabled. A REBOOT IS REQUIRED.
echo.
set /p reboot="Reboot now? (y/n): "
if /i "!reboot!"=="y" shutdown /r /t 10
goto MAIN_MENU

:INSTALL_TOOLS
cls
echo [+] Installing tools into WSL Ubuntu...
echo [+] This will take a long time. Do not close the window.
echo.
wsl bash -c "sudo apt update && sudo apt install -y git curl python3 python3-pip nmap netcat-openbsd hydra sqlmap metasploit-framework wireshark-common ettercap-graphical aircrack-ng crunch john hashcat recon-ng dirb gobuster nikto wpscan setoolkit"
echo.
echo [+] Installing Python tools...
wsl bash -c "pip3 install requests beautifulsoup4 mechanize"
echo.
echo [+] Tool installation complete.
pause
goto MAIN_MENU

:LAUNCH_HG
cls
echo [+] Checking if WSL and tools are installed...
wsl bash -c "which nmap" >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Tools not found. Please run option [3] first.
    pause
    goto MAIN_MENU
)
echo [+] Launching Hidden.Gov Main Interface...
wsl bash -c "curl -s https://raw.githubusercontent.com/veniceai/hidden-gov-menu/main/hg_menu.sh | bash"
pause
goto MAIN_MENU
