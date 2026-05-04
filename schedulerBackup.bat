# ==============================================================================
# Nazwa skryptu: Backup-CriticalData.ps1
# Opis: Wykonuje archiwizację kluczowych folderów i usuwa stare kopie (retencja).
# ==============================================================================

# Zmienne konfiguracyjne
$SourceFolders = @("C:\Users\$env:USERNAME\Documents", "C:\Users\$env:USERNAME\Desktop")
$BackupDestination = "D:\Backups" # Zmień na swój dysk zapasowy / sieciowy
$RetentionDays = 30
$DateStr = Get-Date -Format "yyyyMMdd_HHmm"
$BackupFile = "$BackupDestination\Backup_$DateStr.zip"

# Upewnij się, że folder docelowy istnieje
if (!(Test-Path $BackupDestination)) {
    Write-Host "Tworzenie folderu docelowego: $BackupDestination" -ForegroundColor Cyan
    New-Item -ItemType Directory -Path $BackupDestination | Out-Null
}

Write-Host "Rozpoczynanie procesu kopii zapasowej..." -ForegroundColor Cyan

# 1. Filtruj foldery, aby archiwizować tylko te, które fizycznie istnieją
$ValidFolders = $SourceFolders | Where-Object { Test-Path $_ }

# 2. Tworzenie archiwum
if ($ValidFolders) {
    try {
        Write-Host "Kompresowanie plików, proszę czekać..." -ForegroundColor Yellow
        Compress-Archive -Path $ValidFolders -DestinationPath $BackupFile -Force
        Write-Host "Kopia zapasowa zakończona sukcesem: $BackupFile" -ForegroundColor Green
    } catch {
        Write-Host "Błąd podczas tworzenia archiwum: $_" -ForegroundColor Red
    }
} else {
    Write-Host "Brak plików do skopiowania (foldery źródłowe nie istnieją)." -ForegroundColor Red
}

# 3. Wykonywanie polityki retencji (czyszczenie starych kopii)
Write-Host "Sprawdzanie polityki retencji ($RetentionDays dni)..." -ForegroundColor Cyan
$LimitDate = (Get-Date).AddDays(-$RetentionDays)

# Zbieranie plików starszych niż data limitu
$OldBackups = Get-ChildItem -Path $BackupDestination -Filter "Backup_*.zip" | 
              Where-Object { $_.CreationTime -lt $LimitDate }

if ($OldBackups) {
    foreach ($Backup in $OldBackups) {
        Remove-Item -Path $Backup.FullName -Force
        Write-Host "Usunięto przestarzałą kopię zapasową: $($Backup.Name)" -ForegroundColor DarkGray
    }
} else {
    Write-Host "Brak starych kopii do usunięcia." -ForegroundColor DarkGray
}

Write-Host "Proces zakończony." -ForegroundColor Green