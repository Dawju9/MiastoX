#!/bin/bash

# Parametry - wprowadź odpowiednie ID i klucz
UNIVERSE_ID="4125094708"
PLACE_ID="11633610328"
API_KEY="/"
FILE_PATH="./build/rojo_output/game.rbxl"  # Ścieżka do pliku .rbxl

# Sprawdzenie, czy plik istnieje
if [ ! -f "$FILE_PATH" ]; then
    echo "Plik .rbxl nie istnieje w ścieżce: $FILE_PATH"
    exit 1
fi

# Wysyłanie pliku za pomocą API Roblox
echo "Publikowanie miejsca na Robloxie..."

curl --verbose --location POST "https://apis.roblox.com/universes/v1/$UNIVERSE_ID/places/$PLACE_ID/versions?versionType=Published" \
--header "x-api-key: $API_KEY" \
--header "Content-Type: application/octet-stream" \
--data-binary @"$FILE_PATH"

if [ $? -eq 0 ]; then
    echo "Miejsce zostało pomyślnie opublikowane!"
else
    echo "Błąd podczas publikacji miejsca."
fi
