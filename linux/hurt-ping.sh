#!/bin/bash

# Tablica z adresami do sprawdzenia
SERWERY=("google.com" "wp.pl" "github.com" "jakistam_nieistniejacy_serwer.com")

echo "Sprawdzanie dostępności serwerów..."
echo "-----------------------------------"

for serwer in "${SERWERY[@]}"; do
    # Wysyłamy 1 pakiet (ping -c 1), ukrywamy wyjście standardowe
    if ping -c 1 -W 2 "$serwer" &> /dev/null; then
        echo -e "[ OK ] $serwer jest dostępny."
    else
        echo -e "[BŁĄD] $serwer nie odpowiada!"
    fi
done

echo "-----------------------------------"
echo "Test zakończony."