#!/bin/bash

echo "======================================"
echo "    RAPORT O STANIE SYSTEMU"
echo "======================================"
echo ""

echo "-> Bieżąca data i czas:"
date
echo ""

echo "-> Czas działania systemu (Uptime):"
uptime -p
echo ""

echo "-> Użycie dysku (partycja główna /):"
df -h / | awk 'NR==2 {print "Całkowite: "$2", Użyte: "$3", Wolne: "$4" ("$5")"}'
echo ""

echo "-> Użycie pamięci RAM:"
free -m | awk 'NR==2 {print "Całkowita: "$2" MB, Używana: "$3" MB, Wolna: "$4" MB"}'
echo ""

echo "======================================"