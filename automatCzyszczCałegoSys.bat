# ==============================================================================
# Nazwa skryptu: Invoke-SystemMaintenance.ps1
# Opis: Czyści pliki tymczasowe, kosz oraz generuje log o stanie dysków.
# ==============================================================================

# Zmienne
$LogDirectory = "C:\Logs"
$LogPath = "$LogDirectory\SystemMaintenance_$(Get-Date -Format 'yyyyMMdd').log"
$TempFolders = @("C:\Windows\Temp\*", "$env:TEMP\*")

# Funkcja pomocnicza do tworzenia logów
Function Write-Log {
    Param([string]$Message)
    $Stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $LogLine = "$Stamp - $Message"
    $LogLine | Out-File -FilePath $LogPath -Append
    Write-Host $LogLine
}

# 1. Przygotowanie środowiska logowania
if (!(Test-Path $LogDirectory)) { 
    New-Item -ItemType Directory -Path $LogDirectory | Out-Null 
}

Write-Log "=== ROZPOCZĘCIE KONSERWACJI SYSTEMU ==="

# 2. Czyszczenie folderów tymczasowych
foreach ($Folder in $TempFolders) {
    Write-Log "Czyszczenie folderu: $Folder"
    Remove-Item -Path $Folder -Recurse -Force -ErrorAction SilentlyContinue
}

# 3. Opróżnianie Kosza
Write-Log "Opróżnianie Kosza (Recycle Bin)..."
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

# 4. Analiza miejsca na dyskach twardych
Write-Log "Skanowanie wolnej przestrzeni dyskowej..."
$Disks = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"

foreach ($Disk in $Disks) {
    $FreeSpaceGB = [math]::Round($Disk.FreeSpace / 1GB, 2)
    $TotalSpaceGB = [math]::Round($Disk.Size / 1GB, 2)
    
    if ($TotalSpaceGB -gt 0) {
        $PercentFree = [math]::Round(($FreeSpaceGB / $TotalSpaceGB) * 100, 2)
        Write-Log "Dysk $($Disk.DeviceID): $FreeSpaceGB GB wolne z $TotalSpaceGB GB ($PercentFree%)."

        if ($PercentFree -lt 15) {
            Write-Log "[OSTRZEŻENIE] Na dysku $($Disk.DeviceID) pozostało mniej niż 15% wolnego miejsca!"
        }
    }
}

Write-Log "=== KONSERWACJA SYSTEMU ZAKOŃCZONA ==="
Write-Log "" # Pusta linia dla czytelności w pliku