Clear-Host
Write-Host "=== SZYBKI RAPORT SYSTEMOWY ===" -ForegroundColor Cyan

# Sprawdzanie miejsca na dysku C:
$dysk = Get-Volume -DriveLetter C
$wolneGB = [math]::Round($dysk.SizeRemaining / 1GB, 2)
Write-Host "Wolne miejsce na dysku C: $wolneGB GB"

# Sprawdzanie czasu działania systemu (Uptime)
$os = Get-CimInstance Win32_OperatingSystem
$czasDzialania = (Get-Date) - $os.LastBootUpTime
Write-Host "Komputer jest włączony od: $($czasDzialania.Days) dni, $($czasDzialania.Hours) godzin i $($czasDzialania.Minutes) minut."

Write-Host "=================================" -ForegroundColor Cyan