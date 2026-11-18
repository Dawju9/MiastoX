# TECHNICAL_DEBT.md

- **Brak struktury kodu:** Logika biznesowa ukryta w pliku binarnym `.rbxl`.
- **Zależności:** Niezrozumiała obecność pakietów typu Node.js w projekcie Roblox (możliwe "przeklejenie" konfiguracji z innego projektu).
- **Konfiguracja:** Rozproszona między `_config.yml`, `.welcome.conf` i `data.s` wewnątrz gry.
