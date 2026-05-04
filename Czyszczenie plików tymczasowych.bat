# Czyszczenie folderu Temp użytkownika
$userTemp = $env:TEMP
Remove-Item -Path "$userTemp\*" -Recurse -Force -ErrorAction SilentlyContinue

# Czyszczenie systemowego folderu Temp (wymaga uprawnień administratora)
$sysTemp = "$env:windir\Temp"
Remove-Item -Path "$sysTemp\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Czyszczenie plików tymczasowych zakończone!" -ForegroundColor Green