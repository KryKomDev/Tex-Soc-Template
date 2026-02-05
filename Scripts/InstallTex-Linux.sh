#!/bin/bash

# ==============================================================================
# Univerzální instalátor: PowerShell, Docker a TeX Live Docker Image
# Podporované systémy: Debian/Ubuntu, RHEL/CentOS/Fedora, Arch Linux
# ==============================================================================

set -e # Okamžité ukončení, pokud příkaz skončí chybou

# --- 1. Pomocné funkce a formátování ---
BOLD="\033[1m"
GREEN="\033[32m"
BLUE="\033[34m"
RED="\033[31m"
RESET="\033[0m"

log_info() { echo -e "${BLUE}[INFO]${RESET} $1"; }
log_success() { echo -e "${GREEN}[OK]${RESET} $1"; }
log_error() { echo -e "${RED}[CHYBA]${RESET} $1"; }

# Kontrola oprávnění root
if [ "$EUID" -ne 0 ]; then
  log_error "Prosím, spusťte tento skript jako root (použijte sudo)."
  exit 1
fi

# --- 2. Detekce operačního systému ---
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    DISTRO_ID=$ID
else
    log_error "Nelze detekovat OS. Soubor /etc/os-release chybí."
    exit 1
fi

log_info "Detekovaný OS: $OS ($DISTRO_ID)"

# --- 3. Instalace Dockeru (Univerzální metoda) ---
# Používáme oficiální skript get-docker.sh, protože spolehlivě funguje na většině distribucí.
install_docker() {
    if command -v docker &> /dev/null; then
        log_success "Docker je již nainstalován."
    else
        log_info "Instaluji Docker Engine..."
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        rm get-docker.sh
        
        # Spuštění a povolení služby Docker
        systemctl start docker
        systemctl enable docker
        
        # Přidání aktuálního uživatele do skupiny docker (volitelné)
        # usermod -aG docker $SUDO_USER
        log_success "Docker byl úspěšně nainstalován."
    fi
}

# --- 4. Instalace PowerShellu (Specifické pro distribuci) ---
install_powershell() {
    if command -v pwsh &> /dev/null; then
        log_success "PowerShell je již nainstalován."
        return
    fi

    log_info "Instaluji PowerShell..."

    case "$DISTRO_ID" in
        ubuntu|debian|kali|pop)
            # Prerekvizity
            apt-get update && apt-get install -y wget apt-transport-https software-properties-common
            
            # Stažení GPG klíčů Microsoft repozitáře
            wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
            dpkg -i packages-microsoft-prod.deb
            rm packages-microsoft-prod.deb
            
            apt-get update
            apt-get install -y powershell
            ;;

        centos|rhel|fedora|rocky|almalinux)
            # Registrace Microsoft RedHat repozitáře
            curl https://packages.microsoft.com/config/rhel/8/prod.repo | tee /etc/yum.repos.d/microsoft.repo
            yum install -y powershell
            ;;

        arch|manjaro)
            # Arch používá AUR nebo komunitní balíčky.
            # Zkusíme standardní instalaci přes pacman.
            pacman -Sy --noconfirm powershell || log_error "PowerShell nebyl nalezen v repozitářích Archu. Prosím nainstalujte 'powershell-bin' pomocí AUR helperu (např. yay nebo paru)."
            ;;

        *)
            log_error "Automatická instalace PowerShellu není pro $DISTRO_ID přímo podporována. Zkuste 'snap install powershell --classic', pokud máte snap."
            ;;
    esac

    if command -v pwsh &> /dev/null; then
        log_success "PowerShell byl nainstalován."
    fi
}

# --- 5. Stažení Docker obrazu TeX Live ---
pull_texlive() {
    log_info "Stahuji oficiální Docker obraz TeX Live (texlive/texlive)..."
    log_info "Poznámka: Toto je velký obraz (cca 2GB+)."
    
    if docker pull texlive/texlive; then
        log_success "Obraz TeX Live byl úspěšně stažen."
    else
        log_error "Nepodařilo se stáhnout obraz TeX Live. Běží služba Docker?"
        exit 1
    fi
}

# --- Spuštění ---
log_info "Spouštím univerzální instalační skript..."

install_docker
install_powershell
pull_texlive

echo -e "\n${BOLD}Instalace dokončena!${RESET}"
echo -e "1. ${BOLD}PowerShell${RESET}: Spusťte příkazem 'pwsh'"
echo -e "2. ${BOLD}Docker${RESET}: Ověřte příkazem 'docker ps'"
echo -e "3. ${BOLD}TeX Live${RESET}: Spusťte kontejner pomocí:"
echo -e "   ${GREEN}docker run -it --rm -v \$(pwd):/workdir texlive/texlive pdflatex vas_soubor.tex${RESET}"