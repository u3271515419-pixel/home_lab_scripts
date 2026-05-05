#!/bin/bash

# Zdefiniuj katalogi (zmień według własnych potrzeb)
KATALOG_ZRODLOWY="$HOME/Dokumenty"
KATALOG_DOCELOWY="$HOME/Kopie_Zapasowe"

# Pobranie aktualnej daty
DATA=$(date +%Y-%m-%d_%H-%M-%S)
NAZWA_ARCHIWUM="backup_$DATA.tar.gz"

# Sprawdzenie czy katalog docelowy istnieje, jeśli nie - stwórz go
if [ ! -d "$KATALOG_DOCELOWY" ]; then
    mkdir -p "$KATALOG_DOCELOWY"
fi

echo "Rozpoczynam tworzenie kopii zapasowej katalogu $KATALOG_ZRODLOWY..."

# Tworzenie archiwum
tar -czf "$KATALOG_DOCELOWY/$NAZWA_ARCHIWUM" "$KATALOG_ZRODLOWY" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Kopia zapasowa zakończona sukcesem!"
    echo "Plik zapisano w: $KATALOG_DOCELOWY/$NAZWA_ARCHIWUM"
else
    echo "❌ Wystąpił błąd podczas tworzenia kopii."
fi