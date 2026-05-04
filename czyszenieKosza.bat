# Opróżnia kosz bez pytania użytkownika o zgodę
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

Write-Host "Kosz został opróżniony." -ForegroundColor Yellow