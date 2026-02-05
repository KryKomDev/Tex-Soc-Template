#!/bin/bash

# ==============================================================================
# macOS Instalátor: PowerShell, Docker a TeX Live Docker Image
# Prerekvizity: Vyžaduje instalaci Homebrew (skript se ji pokusí provést)
# ==============================================================================

set -e

# --- 1. Formátování a pomocné funkce ---
BOLD="\033[1m"
GREEN="\033[32m"
BLUE="\033[34m"
RED="\033[31m"
RESET="\033[0m"

log_info() { echo -e "${BLUE}[INFO]${RESET} $1"; }
log_success() { echo -e "${GREEN}[OK]${RESET} $1"; }
log_error() { echo -e "${RED}[CHYBA]${RESET} $1"; }

# Kontrola: Na macOS nespouštějte Homebrew jako root
if [ "$EUID" -eq 0 ]; then
  log_error "Nespouštějte tento skript jako root (nepoužívejte sudo)."
  log_error "Homebrew vyžaduje spuštění pod běžným uživatelem."
  exit 1
fi

# --- 2. Kontrola / Instalace Homebrew ---
if ! command -v brew &> /dev/null; then
    log_info "Homebrew nebyl nalezen. Zahajuji instalaci Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Přidání Homebrew do PATH pro aktuální sezení (pro Apple Silicon i Intel)
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    log_success "Homebrew je již nainstalován."
fi

# Aktualizace Homebrew
log_info "Aktualizuji repozitáře Homebrew..."
brew update

# --- 3. Instalace PowerShellu ---
if brew list --cask powershell &> /dev/null; then
    log_success "PowerShell je již nainstalován."
else
    log_info "Instaluji PowerShell..."
    brew install --cask powershell
fi

# --- 4. Instalace Docker Desktop ---
if brew list --cask docker &> /dev/null; then
    log_success "Docker Desktop je již nainstalován."
else
    log_info "Instaluji Docker Desktop..."
    brew install --cask docker
fi

# --- 5. Spuštění Dockeru a čekání na Engine ---
# Na macOS instalace nespustí daemona. Musíme otevřít aplikaci.
log_info "Spouštím aplikaci Docker Desktop..."
open -a Docker

log_info "Čekám na inicializaci Docker Engine (může to trvat minutu)..."

# Smyčka čekající na dostupnost 'docker info'
RETRIES=0
MAX_RETRIES=40 # Cca 2 minuty
DOCKER_READY=false

while [ $RETRIES -lt $MAX_RETRIES ]; do
    if docker info &> /dev/null; then
        DOCKER_READY=true
        break
    fi
    echo -n "."
    sleep 3
    ((RETRIES++))
done
echo "" # Nový řádek

if [ "$DOCKER_READY" = false ]; then
    log_error "Docker Engine neodpovídá. Prosím dokončete nastavení Docker Desktop ručně (přijměte podmínky v okně aplikace)."
    exit 1
else
    log_success "Docker Engine běží!"
fi

# --- 6. Stažení obrazu TeX Live ---
log_info "Stahuji oficiální Docker obraz TeX Live (texlive/texlive)..."
log_info "Poznámka: Toto je velký obraz (>2GB)."

if docker pull texlive/texlive; then
    log_success "Obraz TeX Live byl úspěšně stažen."
else
    log_error "Nepodařilo se stáhnout obraz. Zkontrolujte připojení."
    exit 1
fi

# --- Závěr ---
echo -e "\n${BOLD}Instalace dokončena!${RESET}"
echo -e "1. ${BOLD}PowerShell${RESET}: Spusťte příkazem 'pwsh'"
echo -e "2. ${BOLD}Docker${RESET}: Aplikace běží v horní liště."
echo -e "3. ${BOLD}TeX Live${RESET}: Spusťte kontejner pomocí:"
echo -e "   ${GREEN}docker run -it --rm -v \$(pwd):/workdir texlive/texlive pdflatex vas_soubor.tex${RESET}"