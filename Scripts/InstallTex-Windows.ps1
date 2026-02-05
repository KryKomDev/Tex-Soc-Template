<#
.SYNOPSIS
    Nainstaluje Docker Desktop a stáhne Docker obraz TeX Live na Windows.
    
.DESCRIPTION
    1. Zkontroluje oprávnění správce (Administrator).
    2. Nainstaluje Docker Desktop pomocí Winget.
    3. Spustí Docker Desktop a počká na inicializaci enginu.
    4. Stáhne obraz texlive/texlive.
#>

$ErrorActionPreference = "Stop"

# --- 1. Pomocné funkce ---
function Write-Log {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host "[INFO] $Message" -ForegroundColor $Color
}

function Write-ErrorLog {
    param([string]$Message)
    Write-Host "[CHYBA] $Message" -ForegroundColor Red
}

# --- 2. Kontrola oprávnění správce ---
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-ErrorLog "Prosím, spusťte tento skript jako Správce (Administrator)."
    Write-Host "Klikněte pravým tlačítkem na skript a vyberte 'Spustit pomocí PowerShell' nebo spusťte z terminálu pro správce."
    exit 1
}

# --- 3. Instalace Docker Desktop ---
if (Get-Command "docker" -ErrorAction SilentlyContinue) {
    Write-Log "Docker je již nainstalován." -Color Green
}
else {
    Write-Log "Docker nebyl nalezen. Instaluji Docker Desktop přes Winget..."
    
    # Kontrola existence Winget
    if (-not (Get-Command "winget" -ErrorAction SilentlyContinue)) {
        Write-ErrorLog "Winget (Správce balíčků Windows) nebyl nalezen. Prosím aktualizujte Windows nebo nainstalujte App Installer z Microsoft Store."
        exit 1
    }

    try {
        # Tichá instalace Docker Desktop
        winget install -e --id Docker.DockerDesktop --accept-package-agreements --accept-source-agreements
        
        Write-Log "Docker Desktop byl úspěšně nainstalován." -Color Green
        Write-Log "DŮLEŽITÉ: Možná bude nutné restartovat počítač pro dokončení instalace WSL 2." -Color Yellow
        
        # Obnovení proměnných prostředí, aby byl příkaz 'docker' dostupný bez restartu shellu
        foreach($level in "Machine","User") {
           [Environment]::GetEnvironmentVariables($level).GetEnumerator() | % {
              if($_.Name -match 'Path') {
                 [Environment]::SetEnvironmentVariable($_.Name, $_.Value, "Process")
              }
           }
        }
    }
    catch {
        Write-ErrorLog "Nepodařilo se nainstalovat Docker. Prosím nainstalujte Docker Desktop ručně."
        exit 1
    }
}

# --- 4. Spuštění Docker Desktop a čekání na Engine ---
Write-Log "Kontroluji, zda běží Docker Engine..."

# Zkusíme spustit Docker Desktop, pokud proces neběží
if (-not (Get-Process "Docker Desktop" -ErrorAction SilentlyContinue)) {
    Write-Log "Spouštím aplikaci Docker Desktop..."
    $dockerPath = "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    
    if (Test-Path $dockerPath) {
        Start-Process $dockerPath
    }
    else {
        Write-ErrorLog "Nelze najít spustitelný soubor Docker Desktop. Prosím spusťte jej ručně."
    }
}

# Smyčka čekající na úspěch příkazu 'docker info' (indikuje, že je engine připraven)
$retries = 0
$maxRetries = 30 # Čekání cca 60-90 sekund
$dockerReady = $false

while ($retries -lt $maxRetries) {
    try {
        $null = docker info 2>&1
        if ($LASTEXITCODE -eq 0) {
            $dockerReady = $true
            break
        }
    }
    catch {
        # Ignorování chyb během čekání
    }
    
    Write-Host -NoNewline "."
    Start-Sleep -Seconds 3
    $retries++
}
Write-Host "" # Nový řádek

if (-not $dockerReady) {
    Write-ErrorLog "Docker Engine zatím neodpovídá."
    Write-ErrorLog "Pokud jste Docker právě nainstalovali, pravděpodobně musíte RESTARTOVAT počítač pro aktivaci funkcí WSL 2."
    Write-ErrorLog "Prosím restartujte počítač, spusťte Docker Desktop a spusťte tento skript znovu."
    exit 1
}

Write-Log "Docker Engine běží!" -Color Green

# --- 5. Stažení obrazu TeX Live ---
Write-Log "Stahuji obraz texlive/texlive (Poznámka: Velikost >2GB)..."

try {
    docker pull texlive/texlive
    Write-Log "Obraz TeX Live byl úspěšně stažen!" -Color Green
}
catch {
    Write-ErrorLog "Nepodařilo se stáhnout obraz. Zkontrolujte připojení k internetu."
    exit 1
}

# --- 6. Instrukce k použití ---
Write-Host "--------------------------------------------------------"
Write-Log "Instalace dokončena." -Color Green
Write-Host "Pro použití TeX Live použijte v PowerShellu následující příkaz:"
Write-Host "docker run --rm -v `"$(pwd):/workdir`" texlive/texlive pdflatex vas_soubor.tex" -ForegroundColor Yellow
Write-Host "--------------------------------------------------------"