/**
 * MiastoX — Main JavaScript
 * Dynamically populates pages from API data
 */

// ── Data: Ranks Hierarchy ──
const RANKS = {
  royal: [
    {
      id: "owner",
      name: "Owner",
      role: "Król Świata",
      desc: "Właściciel serwera. Najwyższa władza w mieście. Zarządza wszystkim i wszystkimi.",
      color: "#f0c040",
      icon: "👑"
    },
    {
      id: "admin",
      name: "Admin",
      role: "Służba Królewska",
      desc: "Administratorzy serwera. Egzekwują regulamin, zarządzają rangami i dbają o porządek.",
      color: "#e94560",
      icon: "🛡️"
    },
    {
      id: "moderator",
      name: "Moderator",
      role: "Straż Królewska",
      desc: "Moderatorzy czatu i gry. Patrolują miasto, reagują na zgłoszenia graczy.",
      color: "#4fc3f7",
      icon: "⚔️"
    },
    {
      id: "helper",
      name: "Helper",
      role: "Pomocnicy Królewscy",
      desc: "Pomagają nowym graczom, odpowiadają na pytania, wspierają społeczność.",
      color: "#81c784",
      icon: "🤝"
    }
  ],
  citizen: [
    {
      id: "citizen",
      name: "Obywatel",
      role: "Pełnoprawny Mieszkaniec",
      desc: "Podstawowa ranga dla stałych graczy. Dostęp do wszystkich dzielnic i systemów gry.",
      color: "#ffffff",
      icon: "🏠"
    },
    {
      id: "seller",
      name: "Sprzedawca",
      role: "Handel i Stoiska",
      desc: "Prowadzi handel w Dzielnicy Kupieckiej. Może wystawiać przedmioty na sprzedaż.",
      color: "#ffb74d",
      icon: "🏪"
    },
    {
      id: "robber",
      name: "Rabuś",
      role: "Podziemie i Kradzieże",
      desc: "Działa w Slumsach. Specjalizuje się w kradzieżach i systemie QTE.",
      color: "#ef5350",
      icon: "🦹"
    },
    {
      id: "official",
      name: "Urzędnik",
      role: "Administracja Miasta",
      desc: "Zarządza dokumentacją miasta, wydaje pozwolenia, prowadzi rejestr obywateli.",
      color: "#64b5f6",
      icon: "📋"
    },
    {
      id: "builder",
      name: "Budowniczy",
      role: "Budowa i Naprawy",
      desc: "Buduje i naprawia konstrukcje w mieście. Dostęp do specjalnych narzędzi budowlanych.",
      color: "#ffcc80",
      icon: "🔨"
    },
    {
      id: "worker",
      name: "Worker",
      role: "Prace Miejskie",
      desc: "Wykonuje zadania miejskie: sprzątanie, transport, konserwacja.",
      color: "#a5d6a7",

// ── Data: Jobs ──
const JOBS = [
  {
    id: "shop-owner",
    name: "Właściciel Sklepu",
    tier: "citizen",
    desc: "Prowadź własny sklep w Dzielnicy Kupieckiej. Sprzedawaj power-upy, bronie i akcesoria.",
    income: "Prowizja od sprzedaży"
  },
  {
    id: "police",
    name: "Policjant",
    tier: "citizen",
    desc: "Patroluj miasto, ścigaj rabusiów, utrzymuj porządek w dzielnicach.",
    income: "Stała pensja + premie za aresztowania"
  },
  {
    id: "constructor",
    name: "Konstruktor",
    tier: "citizen",
    desc: "Buduj nowe obiekty miejskie, naprawiaj zniszczone konstrukcje, wznawiaj rusztowania.",
    income: "Wynagrodzenie za ukończone projekty"
  },
  {
    id: "thief",
    name: "Złodziej",
    tier: "citizen",
    desc: "Okradaj bankomaty i sklepy. Uważaj na policję! System QTE z rękawiczkami.",
    income: "Łup z udanych kradzieży"
  },
  {
    id: "trader",
    name: "Handlarz",
    tier: "citizen",
    desc: "Kupuj tanio, sprzedawaj drogo. Spekuluj na rynku miejskim.",
    income: "Marża handlowa"
  },
  {
    id: "guide",
    name: "Przewodnik",
    tier: "citizen",

// ── Render Functions ──

function renderRanks() {
  const royalContainer = document.getElementById("royal-ranks");
  const citizenContainer = document.getElementById("citizen-ranks");

  if (!royalContainer && !citizenContainer) return;

  if (royalContainer) {
    royalContainer.innerHTML = RANKS.royal.map(r => `
      <div class="rank-card" style="border-left: 3px solid ${r.color}">
        <h3>${r.icon} ${r.name}</h3>
        <div class="rank-role" style="color:${r.color}">${r.role}</div>
        <p class="rank-desc">${r.desc}</p>
      </div>
    `).join("");
  }

  if (citizenContainer) {
    citizenContainer.innerHTML = RANKS.citizen.map(r => `
      <div class="rank-card" style="border-left: 3px solid ${r.color}">
        <h3>${r.icon} ${r.name}</h3>
        <div class="rank-role" style="color:${r.color}">${r.role}</div>
        <p class="rank-desc">${r.desc}</p>
      </div>
    `).join("");
  }
}

function renderJobs() {
  const container = document.getElementById("jobs-list");
  if (!container) return;

  container.innerHTML = JOBS.map(j => `
    <div class="job-card">
      <h3>${j.name}</h3>
      <span class="job-tier-badge ${j.tier}">${j.tier === 'royal' ? 'Royal Tier' : 'Citizen Tier'}</span>
      <p>${j.desc}</p>
      <p style="margin-top:10px; color: var(--text-dim)">💰 ${j.income}</p>
    </div>
  `).join("");
}

function renderChangelog() {
  const container = document.getElementById("changelog-entries");
  if (!container) return;

  fetch("api/changelog.json")
    .then(res => res.json())
    .then(entries => {
      container.innerHTML = entries.map(e => `
        <div class="changelog-entry">
          <div class="commit-hash">${e.hash}</div>
          <div class="commit-date">${e.date}</div>
          <div class="commit-msg">${e.message}</div>
        </div>
      `).join("");
    })
    .catch(() => {
      container.innerHTML = `
        <div class="changelog-entry">
          <p>⚠️ Nie można załadować changeloga. Sprawdź <a href="https://github.com/Dawju9/MiastoX/commits/main">GitHub</a>.</p>
        </div>`;
    });
}

function loadStatus() {
  fetch("api/status.json")
    .then(res => res.json())
    .then(data => {
      const versionEl = document.getElementById("version");
      const buildEl = document.getElementById("last-build");
      const playersEl = document.getElementById("players");
      if (versionEl) versionEl.textContent = data.version || "—";
      if (buildEl) buildEl.textContent = data.lastBuild || "—";
      if (playersEl) playersEl.textContent = data.players || "—";
    })
    .catch(() => {
      const versionEl = document.getElementById("version");
      const buildEl = document.getElementById("last-build");
      if (versionEl && !versionEl.textContent.includes("—")) versionEl.textContent = "—";
      if (buildEl && !buildEl.textContent.includes("—")) buildEl.textContent = "—";
    });
}

// ── Init ──
document.addEventListener("DOMContentLoaded", () => {
  renderRanks();
  renderJobs();
  renderChangelog();
  loadStatus();
});

    desc: "Oprowadzaj nowych graczy po mieście, pokazuj tajne przejścia i skróty.",
    income: "Napiwki od graczy"
  },
  {
    id: "climber",
    name: "Wspinacz",
    tier: "citizen",
    desc: "Specjalizuj się we wspinaczce. Bij rekordy wysokości i zdobywaj prestiż.",
    income: "Punkty prestiżu + bonusy za rekordy"
  }
];

      icon: "🛠️"
    },
    {
      id: "civilian",
      name: "Cywil",
      role: "Podstawowa Ranga",
      desc: "Domyślna ranga dla nowych graczy. Ograniczony dostęp do systemów.",
      color: "#bdbdbd",
      icon: "🚶"
    }
  ]
};
