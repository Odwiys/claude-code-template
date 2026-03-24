# claude-code-template

A batteries-included project template for [Claude Code](https://claude.ai/claude-code). Clone it once, scaffold new projects in seconds.

## What's included

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Pre-filled Claude Code instructions — constraints, code style, git rules, permissions |
| `.gitignore` | Covers Python, JS/TS, editors, OS files, and secrets |
| `.mcp.json` | Pre-configured MCP servers (Vercel, Supabase, MongoDB, Playwright, Stripe) |
| `.claude/settings.json` | Claude Code permissions baseline |
| `new-project.sh` | Scaffold script — creates a new project from this template |

## Usage

### Option 1 — Local (if you have this repo cloned)

```bash
./new-project.sh my-project
./new-project.sh my-project ~/dev/projects
```

### Option 2 — From GitHub (no local clone needed)

```bash
new-project.sh --github my-project
new-project.sh --github my-project ~/dev/projects
```

Both create a new directory with a clean git history, ready to build.

## Setup

1. Clone this repo somewhere permanent (e.g. `~/dev/claude-code-template`)
2. Add `new-project.sh` to your `$PATH` for easy access from anywhere
3. Run `new-project.sh <project-name>` whenever you start something new
