<div align="center">
  
  <div align="center">
    ---
    <br>
      # 🏙️ **CityX Framework by Whitekali** 🖤🖥️
    <br>
    ---
  </div>
 
  <div align="left"> 
  --- 
    <br>
      [Live status# 🏙️ CityX](https://dawju9.github.io/MiastoX/) 🖤🖥️
    <br>
  ---
    
  </div>
    <div align="left">
      <div class="code">
         ```rs
          🔍 Kluczowe Funkcje
          Modularność i dostępność do ustawień całości gry jak i miasta
          Efektywne Zarządzanie Danymi modelami wielkościami a nawet i logiką samej fizyki
          ```
      ,Code White
      </div>
      <div class="code">
                          ```
        Podstawowe Założenia
        Wczesne ładowanie: Sprawdzanie zależności i obecności kluczowych elementów (modele, dane, tekstury).
        Modularna struktura: Skrypty i elementy podzielone na funkcjonalne grupy.
        Prosty interfejs użytkownika: Nakładające się menu (Start, Pauza, Wyjście).
        Mechanika gry: Sterowanie graczem i podstawowe interakcje.
        Proceduralność: Generowanie budynków w świecie gry na podstawie predefiniowanych danych.
```
      ,Code White
      </div>
  </div>
</div>

<div align="center">
---
<div align="center"># 🏙️ **CityX Framework by Whitekali** 🖤🖥️</div>
---
<br>

---
<div align="left"> 
[Live status# 🏙️ CityX](https://dawju9.github.io/MiastoX/) 🖤🖥️</div>
---
```rs
**🔍 Kluczowe Funkcje**
<div align="left">
Modularność i dostępność do ustawień całości gry jak i miasta
Efektywne Zarządzanie Danymi modelami wielkościami a nawet i logiką samej fizyki
</div>
```
---
---
💡 Wpływ na Informatyzację
---
Efektywność
Innowacja
Skalowalność
---
🌐 Potencjalne Zastosowania
---
Gry Multiplayer
Aplikacje Webowe
Narzędzia Edukacyjne
---
📝 Uwagi
---
Projekt wymaga doświadczenia w środowisku Roblox i Rust.
Dokumentacja obejmuje kluczowe aspekty.
Kluczowe algorytmy oraz struktury są chronione.
---
🎮 Rozpoczęcie Przygody w CityX
🌌 Zanurz się w cybernetycznym świecie!
</div>

---
<div align="left">
## 👤 **Kontakt**

- **Autor**: Whitekali
- **E-mail**: whitekali@example.com
- **GitHub**: [Dawju9](https://github.com/Dawju9)

</div>
---
## **Gotowy na Przygody?**

<div align="left">
Odkryj sekrety CityX i zmierz się z wyzwaniami! 🏙️✨

</div>
</div>
<div align="center">
🏗️ Struktura Projektu
<div align="left">
/cityx-backend: Rust
/cityx-client: Roblox Lua
/cityx-core: Roblox Lua
/cityx-server: Roblox Lua
/cityx-renderer: Rust
/game: Zasoby gry

</div> [miro](https://miro.com/app/board/uXjVKtfWXNY=/?share_link_id=381033713650)

🛠️ Instalacja i Konfiguracja
Zainstaluj Roblox Studio
Skonfiguruj Środowisko Rust
Zarządzanie zależnościami: Wally
Uruchomienie: Skrypt roblox lub scripts/install_packages.sh
🖥️ Główne Komponenty
Backend (Rust)
Frontend (Roblox Lua)
Core (Lua)
Renderer (Rust)
</div>
# [WORKSPACE] - Lista pytań do implementacji funkcji

## Preładowanie Gry
**Nazwa skryptu**: `PreloadGameSetup.luau`

### Funkcje do zaimplementowania:
- Jakie zasoby muszą być preładowane przed rozpoczęciem gry? (modele, tekstury, inne)
- Jak skonfigurować początkowe ustawienia gry? (zmienne globalne, stałe)
- Jakie zdarzenia muszą być powiązane przed rozpoczęciem gry? (np. obsługa połączeń gracza)
- Jak generować siatkę i trasy w przestrzeni roboczej?
- Czy istnieje potrzeba zintegrowania zewnętrznych modułów do generowania środowiska?

---

### Pytania szczegółowe:
1. **Preładowanie zasobów**
   - Jakie dokładnie modele, tekstury lub inne zasoby powinny być preładowane? 
   - Czy istnieją określone priorytety ładowania zasobów?
   - Jakie podejście do przechowywania i zarządzania zasobami będzie najbardziej efektywne?

2. **Ustawienia początkowe gry**
   - Jakie globalne zmienne i stałe muszą zostać zdefiniowane na początku?
   - Czy istnieją ustawienia konfiguracyjne zależne od trybu gry?
   - Jakie są wymagane wartości domyślne dla różnych parametrów rozgrywki?

3. **Wiązanie zdarzeń**
   - Które zdarzenia wymagają powiązania przed pełnym wczytaniem gry?
   - Czy istnieje potrzeba obsługi dynamicznego wiązania zdarzeń, np. w zależności od liczby graczy?

4. **Generacja siatki i tras**
   - Jakie algorytmy będą używane do generowania siatki?
   - Czy istnieje określona logika definiowania tras w grze?
   - Czy siatka powinna być aktualizowana dynamicznie w trakcie gry?

---

### Dodatkowe funkcje do przemyślenia:
- Funkcja do preładowania zasobów (`preloadAssets()`)
- Funkcja konfigurująca ustawienia gry (`setupGameSettings()`)
- Funkcja do wiązania zdarzeń (`bindPreloadEvents()`)
- Funkcja generująca układ miasta (`generateCityLayout()`)

---

### Uwagi do skryptu `PreloadGameSetup`:
- Skrypt ten powinien kompleksowo przygotowywać grę poprzez wczytanie zasobów, konfigurację początkową, wiązanie zdarzeń oraz generację środowiska gry.
