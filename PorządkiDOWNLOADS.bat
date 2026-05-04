$pobrane = "$HOME\Downloads"
$dokumenty = "$HOME\Documents"
$obrazy = "$HOME\Pictures"

# Przenoszenie dokumentów
Move-Item -Path "$pobrane\*.pdf", "$pobrane\*.docx", "$pobrane\*.xlsx" -Destination $dokumenty -ErrorAction SilentlyContinue

# Przenoszenie obrazów
Move-Item -Path "$pobrane\*.jpg", "$pobrane\*.png", "$pobrane\*.jpeg" -Destination $obrazy -ErrorAction SilentlyContinue

Write-Host "Folder Pobrane został posprzątany!" -ForegroundColor Green