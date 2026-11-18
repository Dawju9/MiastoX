# n8n MCP — MiastoX Automation Setup

## What is n8n MCP?

The **Model Context Protocol (MCP)** node in n8n exposes your n8n workflows as tools that AI agents (like Cline/Claude) can call. This lets you say:

> "Build MiastoX and deploy the website"

And Cline will automatically call n8n to run the build pipeline and website deployment.

---

## Step 1: Install & Start n8n

### Option A: Docker (Recommended)
```bash
docker run -d \
  --name n8n-miastox \
  --restart unless-stopped \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  -v /Development/repos/MiastoX:/Development/repos/MiastoX \
  -e N8N_AI_ENABLED=true \
  -e WEBHOOK_URL=http://localhost:5678 \
  n8nio/n8n:latest
```

### Option B: npm
```bash
npm install -g n8n
n8n start
```

Access: **http://localhost:5678**

---

## Step 2: Import Workflows

1. Open n8n → **Workflows** → **Import from File**
2. Import these files from `n8n/`:
   - `workflow-build.json` — MiastoX build pipeline
   - `workflow-website-deploy.json` — Website generation & deploy
3. **Activate** each workflow (toggle in top-right)

---

## Step 3: Configure API Key for MCP

1. n8n → **Settings** → **API** → Create API Key
2. n8n → **Settings** → **MCP** → Enable MCP Server
3. Note the MCP endpoint: `http://localhost:5678/mcp`

---

## Step 4: Connect Cline to n8n MCP

Add to your Cline MCP configuration (`.cline/mcp.json` or equivalent):

```json
{
  "mcpServers": {
    "n8n-miastox": {
      "type": "http",
      "url": "http://localhost:5678/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_N8N_API_KEY"
      }
    }
  }
}
```

Restart Cline after adding this configuration.

---

## Step 5: Verify Connection

Once configured, Cline will see these tools:

| Tool Name | Description |
|-----------|-------------|
| `miastox-build` | Runs full build: pull → install → lint → build → artifact |
| `miastox-deploy-website` | Generates website from game data + deploys to GitHub Pages |

Test by asking Cline:

> "Build MiastoX production artifact using n8n"

---

## Usage Examples

### Build Game Artifact
```
User: "Build MiastoX production"
→ Cline calls miastox-build via MCP
→ n8n runs: git pull → wally install → selene lint → rojo build
→ Returns: { status: "success", artifact: "MiastoX.rbxl" }
```

### Deploy Website
```
User: "Deploy MiastoX website"
→ Cline calls miastox-deploy-website via MCP
→ n8n runs: git pull → generate changelog → write API files → push gh-pages
→ Returns: { status: "deployed", url: "https://Dawju9.github.io/MiastoX" }
```

### Scheduled Full Pipeline
Set up a **Schedule Trigger** in n8n for cron-based automation:
- Every push to `main` → auto-build
- Every night at 2am → regenerate website with latest changelog
- Every release tag → build + deploy both game and website

---

## Architecture Diagram

```
┌──────────────┐     MCP (JSON-RPC)     ┌─────────────────┐
│   Cline AI   │ ◄──────────────────────►│   n8n Server    │
│  (Terminal)  │     http://:5678/mcp   │   (port 5678)   │
└──────────────┘                        └────────┬────────┘
                                                  │
                    ┌─────────────────────────────┼─────────────────────────────┐
                    │                             │                             │
                    ▼                             ▼                             ▼
            ┌──────────────┐            ┌──────────────────┐          ┌──────────────┐
            │ Build        │            │ Website Deploy   │          │ Notify       │
            │ Workflow     │            │ Workflow         │          │ Workflow     │
            └──────┬───────┘            └────────┬─────────┘          └──────┬───────┘
                   │                             │                           │
                   ▼                             ▼                           ▼
            ┌──────────────┐            ┌──────────────────┐          ┌──────────────┐
            │ Shell cmds:  │            │ Generate JSONs   │          │ Discord      │
            │ git pull     │            │ git log → change │          │ Webhook      │
            │ wally install│            │ Write API files  │          │ "Done!"      │
            │ selene lint  │            │ Push gh-pages    │          │              │
            │ rojo build   │            └──────────────────┘          └──────────────┘
            └──────────────┘
```

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| "Connection refused" | Make sure n8n is running: `docker ps \| grep n8n` |
| "Unauthorized" | Check API key in MCP config matches n8n Settings → API |
| "Workflow not found" | Make sure workflow is **Activated** in n8n |
| Build fails | Run manually first: `cd /Development/repos/MiastoX && bash scripts/build.sh` |
| gh-pages push fails | Set up GitHub token: `git remote set-url origin https://TOKEN@github.com/Dawju9/MiastoX.git` |
