const RANK_DATA = {
    name: "Owner",
    title: "Founder / Owner",
    color: "#ffd700",
    description: "Highest administrative authority. Server ownership, final decisions, infrastructure management.",
    children: [
        {
            name: "Admin",
            title: "Administrator",
            color: "#ff4444",
            description: "Full server management. User management, configuration, event oversight, conflict resolution.",
            children: [
                {
                    name: "Moderator",
                    title: "Moderator",
                    color: "#ff8800",
                    description: "Chat moderation, rule enforcement, player support, report handling.",
                    children: [
                        {
                            name: "Helper",
                            title: "Helper",
                            color: "#44bbff",
                            description: "Player assistance, answering questions, guiding new players, reporting issues to moderators.",
                            children: [
                                {
                                    name: "Obywatel",
                                    title: "Citizen",
                                    color: "#44dd44",
                                    description: "Regular player with full city privileges. Can own property, participate in economy.",
                                    children: [
                                        {
                                            name: "Sprzedawca",
                                            title: "Seller",
                                            color: "#aa88ff",
                                            description: "Market participant. Can operate shops and trade with other players.",
                                        },
                                        {
                                            name: "Rabuś",
                                            title: "Thief",
                                            color: "#cc4444",
                                            description: "High-risk playstyle. Can attempt robberies (subject to Law System).",
                                        },
                                        {
                                            name: "Urzędnik",
                                            title: "Official",
                                            color: "#66ccff",
                                            description: "City official. Can issue permits, manage municipal services.",
                                        },
                                        {
                                            name: "Budowniczy",
                                            title: "Builder",
                                            color: "#ffaa44",
                                            description: "Construction privileges. Can build and modify structures in designated areas.",
                                        },
                                        {
                                            name: "Worker",
                                            title: "Worker",
                                            color: "#888888",
                                            description: "Basic labor role. Access to job systems and city services.",
                                        },
                                        {
                                            name: "Cywil",
                                            title: "Civilian",
                                            color: "#aaaaaa",
                                            description: "Default role. Basic city access, exploration, and climbing.",
                                        },
                                    ],
                                },
                            ],
                        },
                    ],
                },
            ],
        },
    ],
};

let playersCache = [];

function getDepth(node) {
    if (!node.children || node.children.length === 0) return 0;
    return 1 + Math.max(...node.children.map(getDepth));
}

function rankColor(rankName) {
    function find(node) {
        if (node.name === rankName) return node.color;
        if (node.children) {
            for (const c of node.children) {
                const r = find(c);
                if (r) return r;
            }
        }
        return null;
    }
    return find(RANK_DATA) || "#aaaaaa";
}

function rankOrder(rankName) {
    const order = ["Owner", "Admin", "Moderator", "Helper", "Obywatel", "Sprzedawca", "Rabuś", "Urzędnik", "Budowniczy", "Worker", "Cywil"];
    const idx = order.indexOf(rankName);
    return idx === -1 ? 999 : idx;
}

function buildTree(data) {
    const container = document.getElementById("tree-container");
    if (!container) return;

    const svgNS = "http://www.w3.org/2000/svg";
    const nodeSize = { width: 160, height: 60 };
    const horizontalGap = 40;
    const verticalGap = 80;

    function layout(tree, depth = 0, offset = 0) {
        const x = offset;
        const y = depth * (nodeSize.height + verticalGap);
        const children = (tree.children || []).map((child, i) => {
            return layout(child, depth + 1, offset + i);
        });

        const totalChildrenWidth =
            children.length > 0
                ? children.reduce((sum, c) => sum + c.totalWidth, 0) + (children.length - 1) * horizontalGap
                : 0;

        const treeWidth = Math.max(nodeSize.width, totalChildrenWidth);
        const centerX = offset + treeWidth / 2 - nodeSize.width / 2;
        const nodeX = depth === 0 ? 0 : centerX;

        return {
            name: tree.name,
            title: tree.title,
            color: tree.color,
            description: tree.description,
            children,
            x: nodeX,
            y,
            width: nodeSize.width,
            height: nodeSize.height,
            totalWidth: treeWidth,
        };
    }

    const root = layout(RANK_DATA);

    const maxDepth = getDepth(RANK_DATA);
    const svgWidth = Math.max(root.totalWidth + 40, 600);
    const svgHeight = (maxDepth + 1) * (nodeSize.height + verticalGap) + 20;

    const svg = document.createElementNS(svgNS, "svg");
    svg.setAttribute("width", svgWidth);
    svg.setAttribute("height", svgHeight);
    svg.setAttribute("viewBox", `0 0 ${svgWidth} ${svgHeight}`);
    svg.style.display = "block";
    svg.style.margin = "0 auto";
    svg.style.overflow = "visible";

    function drawLinks(node) {
        if (!node.children) return;
        node.children.forEach((child) => {
            const x1 = node.x + node.width / 2;
            const y1 = node.y + node.height;
            const x2 = child.x + child.width / 2;
            const y2 = child.y;
            const midY = (y1 + y2) / 2;

            const path = document.createElementNS(svgNS, "path");
            const d = `M ${x1} ${y1} C ${x1} ${midY}, ${x2} ${midY}, ${x2} ${y2}`;
            path.setAttribute("d", d);
            path.setAttribute("fill", "none");
            path.setAttribute("stroke", child.color);
            path.setAttribute("stroke-width", "2.5");
            path.setAttribute("opacity", "0.6");
            svg.appendChild(path);

            drawLinks(child);
        });
    }

    drawLinks(root);

    function drawNodes(node) {
        const g = document.createElementNS(svgNS, "g");

        const rect = document.createElementNS(svgNS, "rect");
        rect.setAttribute("x", node.x);
        rect.setAttribute("y", node.y);
        rect.setAttribute("width", node.width);
        rect.setAttribute("height", node.height);
        rect.setAttribute("rx", "8");
        rect.setAttribute("ry", "8");
        rect.setAttribute("fill", node.color);
        rect.setAttribute("opacity", "0.15");
        rect.setAttribute("stroke", node.color);
        rect.setAttribute("stroke-width", "2");

        const nameText = document.createElementNS(svgNS, "text");
        nameText.setAttribute("x", node.x + node.width / 2);
        nameText.setAttribute("y", node.y + node.height / 2 - 4);
        nameText.setAttribute("text-anchor", "middle");
        nameText.setAttribute("alignment-baseline", "middle");
        nameText.setAttribute("fill", node.color);
        nameText.setAttribute("font-size", "14");
        nameText.setAttribute("font-weight", "700");
        nameText.setAttribute("font-family", "'IBM Plex Sans', sans-serif");
        nameText.textContent = node.name;

        const titleText = document.createElementNS(svgNS, "text");
        titleText.setAttribute("x", node.x + node.width / 2);
        titleText.setAttribute("y", node.y + node.height / 2 + 14);
        titleText.setAttribute("text-anchor", "middle");
        titleText.setAttribute("alignment-baseline", "middle");
        titleText.setAttribute("fill", node.color);
        titleText.setAttribute("font-size", "10");
        titleText.setAttribute("opacity", "0.8");
        titleText.setAttribute("font-family", "'IBM Plex Sans', sans-serif");
        titleText.textContent = node.title;

        g.appendChild(rect);
        g.appendChild(nameText);
        g.appendChild(titleText);

        g.style.cursor = "pointer";

        const tooltip = document.createElement("div");
        tooltip.className = "tree-tooltip";
        tooltip.innerHTML = `<strong>${node.name}</strong><br><small>${node.title}</small><br><br>${node.description}`;
        tooltip.style.position = "fixed";
        tooltip.style.display = "none";
        document.body.appendChild(tooltip);

        g.addEventListener("mouseenter", () => {
            rect.setAttribute("opacity", "0.35");
            tooltip.style.display = "block";
        });

        g.addEventListener("mouseleave", () => {
            rect.setAttribute("opacity", "0.15");
            tooltip.style.display = "none";
        });

        g.addEventListener("mousemove", (e) => {
            const x = e.clientX + 15;
            const y = e.clientY + 15;
            tooltip.style.left = Math.min(x, window.innerWidth - tooltip.offsetWidth - 10) + "px";
            tooltip.style.top = Math.min(y, window.innerHeight - tooltip.offsetHeight - 10) + "px";
        });

        svg.appendChild(g);

        if (node.children) {
            node.children.forEach(drawNodes);
        }
    }

    drawNodes(root);
    container.appendChild(svg);
}

function buildDescriptions() {
    const container = document.getElementById("rank-descriptions");
    if (!container) return;

    const list = document.createElement("div");
    list.className = "rank-list";

    function addRank(node, depth = 0) {
        const item = document.createElement("div");
        item.className = "rank-item";
        item.style.marginLeft = depth * 24 + "px";
        item.style.borderLeft = `3px solid ${node.color}`;
        item.style.paddingLeft = "12px";
        item.style.marginBottom = "12px";

        const header = document.createElement("div");
        header.style.display = "flex";
        header.style.alignItems = "center";
        header.style.gap = "10px";

        const badge = document.createElement("span");
        badge.className = "rank-badge";
        badge.style.backgroundColor = node.color;
        badge.textContent = node.name;

        const title = document.createElement("span");
        title.textContent = node.title;
        title.style.fontSize = "14px";
        title.style.opacity = "0.7";

        header.appendChild(badge);
        header.appendChild(title);

        const desc = document.createElement("p");
        desc.textContent = node.description;
        desc.style.margin = "6px 0 0 0";
        desc.style.fontSize = "15px";
        desc.style.lineHeight = "1.4";

        item.appendChild(header);
        item.appendChild(desc);
        list.appendChild(item);

        if (node.children) {
            node.children.forEach((child) => addRank(child, depth + 1));
        }
    }

    addRank(RANK_DATA);
    container.appendChild(list);
}

function buildPlayerRoster(players) {
    const container = document.getElementById("player-roster");
    if (!container) return;

    container.innerHTML = "";

    const grouped = {};
    for (const p of players) {
        if (!grouped[p.rank]) grouped[p.rank] = [];
        grouped[p.rank].push(p);
    }

    const rankNames = Object.keys(grouped).sort((a, b) => rankOrder(a) - rankOrder(b));

    for (const rank of rankNames) {
        const section = document.createElement("div");
        section.className = "player-rank-section";

        const color = rankColor(rank);

        const header = document.createElement("h3");
        header.style.borderLeft = `4px solid ${color}`;
        header.style.paddingLeft = "10px";
        header.style.marginBottom = "6px";
        header.innerHTML = `${rank} <span style="font-size:14px;opacity:0.6;font-weight:400;">(${grouped[rank].length})</span>`;
        section.appendChild(header);

        const sorted = [...grouped[rank]].sort((a, b) => {
            if (a.fresh && !b.fresh) return -1;
            if (!a.fresh && b.fresh) return 1;
            return (b.prestige || 0) - (a.prestige || 0);
        });

        const list = document.createElement("div");
        list.className = "player-list";

        const MAX_VISIBLE = 10;
        const showAll = rank !== "Obywatel" || sorted.length <= MAX_VISIBLE;
        const visibleCount = showAll ? sorted.length : MAX_VISIBLE;

        for (let i = 0; i < sorted.length; i++) {
            const p = sorted[i];
            const row = document.createElement("div");
            row.className = "player-row";
            if (i >= visibleCount) row.classList.add("player-row-hidden");

            const nameSpan = document.createElement("span");
            nameSpan.className = "player-name";
            nameSpan.textContent = p.name;

            const tags = document.createElement("span");
            tags.className = "player-tags";

            if (p.fresh) {
                const tag = document.createElement("span");
                tag.className = "tag tag-fresh";
                tag.textContent = "FRESH";
                tags.appendChild(tag);
            }
            if (p.prestige > 0) {
                const tag = document.createElement("span");
                tag.className = "tag tag-prestige";
                tag.textContent = `${p.prestige} ⬆`;
                tags.appendChild(tag);
            }

            row.appendChild(nameSpan);
            row.appendChild(tags);
            list.appendChild(row);
        }

        section.appendChild(list);

        if (!showAll && sorted.length > MAX_VISIBLE) {
            const toggle = document.createElement("button");
            toggle.className = "player-toggle";
            toggle.textContent = `Show all ${sorted.length} players ▼`;
            toggle.addEventListener("click", () => {
                const hidden = list.querySelectorAll(".player-row-hidden");
                const isExpanded = toggle.textContent.includes("▲");
                hidden.forEach((el) => {
                    el.style.display = isExpanded ? "none" : "flex";
                });
                toggle.textContent = isExpanded
                    ? `Show all ${sorted.length} players ▼`
                    : `Show less ▲`;
            });
            section.appendChild(toggle);
        }

        container.appendChild(section);
    }
}

async function loadPlayers() {
    try {
        const res = await fetch("/api/ranks.json");
        const data = await res.json();
        playersCache = data.players || [];
        document.getElementById("roster-updated").textContent =
            "Last updated: " + new Date(data.updated).toLocaleString();
    } catch {
        playersCache = [];
        document.getElementById("roster-updated").textContent =
            "Could not load player data. API unavailable.";
    }
    buildPlayerRoster(playersCache);
}

document.addEventListener("DOMContentLoaded", () => {
    buildTree(RANK_DATA);
    buildDescriptions(RANK_DATA);
    loadPlayers();
});
