---
layout: default
title: " — O projekcie"
desc: "MiastoX — otwarty projekt gry wspinaczkowej na Roblox. Dowiedz się więcej o technologii, zespole i roadmapie."
permalink: /about
---

<div class="page-header">
  <h1>O <span class="accent">projekcie</span></h1>
  <p>MiastoX to wielopoziomowa gra wspinaczkowa na Roblox, zbudowana na frameworku CityX autorstwa Whitekali.</p>
</div>

<section class="section">
  <h2 class="section-title">Czym jest <span class="accent">MiastoX</span>?</h2>

  <div class="highlight">
    <p><strong>MiastoX</strong> (zapisywane również jako MiastoX) to gra na platformę Roblox, w której gracze wspinają się przez coraz trudniejsze piętra, mierząc się z różnorodnymi typami platform, zmienną pogodą, pułapkami i innymi graczami. Gra jest w pełni darmowa i rozwijana przez społeczność.</p>
  </div>

  <p>Projekt narodził się jako eksperyment z frameworkiem CityX — modułowym systemem serwerowym dla Roblox, który pozwala na izolację stanu gry, automatyczne skalowanie i replikację danych. Z czasem przekształcił się w pełnoprawną grę z 30+ piętrami, 16 typami platform, 7 trybami poziomów i zaawansowanym systemem pogodowym.</p>
</section>

<section class="section">
  <h2 class="section-title">Technologie</h2>

  <div class="card-grid">
    <div class="card">
      <span class="tag tag-luau">Luau</span>
      <h3>Luau</h3>
      <p>Język programowania gry. Bezpieczny, wydajny, z typowaniem — fork Lua 5.1 od Roblox.</p>
    </div>
    <div class="card">
      <span class="tag tag-cityx">CityX</span>
      <h3>CityX Framework</h3>
      <p>Modułowy framework serwerowy autorstwa Whitekali. Zapewnia izolację serwerów, poolowanie i replikację stanu przez Firebase.</p>
    </div>
    <div class="card">
      <span class="tag tag-rojo">Rojo</span>
      <h3>Rojo</h3>
      <p>Narzędzie do synchronizacji kodu źródłowego z Roblox Studio. Pozwala na wersjonowanie i CI/CD.</p>
    </div>
    <div class="card">
      <span class="tag" style="background:#ffd93d20;color:#ffd93d;">Wally</span>
      <h3>Wally</h3>
      <p>Menedżer pakietów dla Roblox. Używamy m.in. Promise, Trove, Signal.</p>
    </div>
    <div class="card">
      <span class="tag" style="background:#00ff8820;color:#00ff88;">CI/CD</span>
      <h3>GitHub Actions</h3>
      <p>Automatyczne lintowanie (Selene), formatowanie (StyLua), build (Rojo) i deploy do Roblox przez rbxcloud.</p>
    </div>
    <div class="card">
      <span class="tag" style="background:#a855f720;color:#a855f7;">Three.js</span>
      <h3>Three.js</h3>
      <p>Interaktywna mapa 3D na stronie projektu, umożliwiająca podgląd pięter i platform w przeglądarce.</p>
    </div>
  </div>
</section>

<section class="section">
  <h2 class="section-title">Zespół</h2>
  <p class="section-sub">Osoby tworzące MiastoX.</p>

  <div class="card-grid-3">
    <div class="card text-center">
      <div class="card-icon"><i class="fas fa-user-cog"></i></div>
      <h3>Dawju9</h3>
      <p style="color:var(--accent-light);font-weight:600;">Developer</p>
      <p>Główny programista gry. Odpowiada za architekturę, mechaniki i integrację z CityX.</p>
    </div>
    <div class="card text-center">
      <div class="card-icon"><i class="fas fa-cubes"></i></div>
      <h3>Whitekali</h3>
      <p style="color:var(--accent-light);font-weight:600;">Twórca CityX</p>
      <p>Autor frameworku CityX, na którym opiera się MiastoX. Modułowy system serwerowy open-source.</p>
    </div>
    <div class="card text-center">
      <div class="card-icon"><i class="fas fa-users"></i></div>
      <h3>Społeczność</h3>
      <p style="color:var(--accent-light);font-weight:600;">Testerzy i tłumacze</p>
      <p>Osoby zgłaszające błędy, tłumaczące grę i pomagające w rozwoju projektu.</p>
    </div>
  </div>
</section>

<section class="section">
  <h2 class="section-title">Status <span class="accent">projektu</span></h2>

  <div class="card-grid">
    <div class="card">
      <div class="card-icon"><i class="fas fa-check-circle" style="color:#00ff88;"></i></div>
      <h3>Wersja</h3>
      <p><strong>v1.0.1</strong> — stabilna, aktywny rozwój. Systemy: generacja poziomów, pogoda, platformy, gracze.</p>
    </div>
    <div class="card">
      <div class="card-icon"><i class="fas fa-rocket" style="color:#ffd93d;"></i></div>
      <h3>W planie</h3>
      <p>Statystyki graczy, tabla wyników, system pogodowy v2, power-upy, strefy PvP i ulepszony system zapisu.</p>
    </div>
    <div class="card">
      <div class="card-icon"><i class="fab fa-github" style="color:#00f5ff;"></i></div>
      <h3>Open Source</h3>
      <p>Kod źródłowy gry dostępny na <a href="https://github.com/Dawju9/MiastoX" target="_blank">GitHub</a> na licencji MIT. Zapraszamy do kontrybucji!</p>
    </div>
  </div>
</section>

<section class="section text-center" style="padding-bottom:80px;">
  <p style="color:var(--text-dim);font-size:0.85rem;">
    MiastoX &copy; 2024-2026 Dawju9 &middot; CityX Framework by Whitekali &middot; MIT License
  </p>
</section>
