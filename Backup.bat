# Zdefiniuj co i gdzie chcesz skopiować
$zrodlo = "C:\MojeProjekty\WazneDane"
$celKatalog = "D:\KopieZapasowe"

# Pobranie dzisiejszej daty w formacie RRRR-MM-DD
$data = Get-Date -Format "yyyy-MM-dd"
$plikDocelowy = "$celKatalog\Backup_$data.zip"

# Tworzenie archiwum
Compress-Archive -Path $zrodlo -DestinationPath $plikDocelowy -Force

Write-Host "Kopia zapasowa utworzona w: $plikDocelowy" -ForegroundColor Cyan