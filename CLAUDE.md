# CLAUDE.md — Claude Code Instructions

This file configures Claude Code's behavior for this project. Keep it updated as the project evolves.

---

## Project Overview

<!-- TODO: Replace this section with a description of what this project does.
Example:
- What problem does it solve?
- Who are the primary users?
- What is the main entry point or deliverable?
-->

**Project Name**: (your-project-name)
**Type**: (web app / backend API / CLI tool / AI agent / library)
**Primary Language(s)**: (Python / TypeScript / Shell)
**Status**: (active development / maintenance / experimental)

---

## Architecture Overview

<!-- TODO: Describe the key components and how they relate to each other.
Example structure:
- src/          — application source code
- tests/        — unit and integration tests
- scripts/      — utility and deployment scripts
- docs/         — documentation
-->

### Key Components

| Component | Path | Purpose |
|-----------|------|---------|
| (e.g. API layer) | `src/api/` | (e.g. FastAPI route handlers) |
| (e.g. Core logic) | `src/core/` | (e.g. business logic) |
| (e.g. Tests) | `tests/` | (e.g. pytest test suite) |

### Data Flow

<!-- TODO: Describe how data moves through the system, e.g.:
1. User request → API layer
2. API layer → service layer
3. Service layer → database
4. Response returned up the chain
-->

---

## Constraints & Policies

- **Never push directly to `main` or `master`**. All changes must go through a pull request.
- **Never merge your own PRs** without review (or without explicit user confirmation in solo projects).
- **Never commit secrets**, API keys, or credentials. Use environment variables or a secrets manager.
- **Never run destructive database operations** (DROP, TRUNCATE, DELETE without WHERE) without explicit confirmation.
- **Never install new dependencies** without checking with the user first.
- **Always prefer reversible actions** — if an operation cannot be undone, ask before proceeding.

---

## Code Style Rules

### Python
- Formatter: **black** (`black .`)
- Linter: **ruff** (`ruff check .`)
- Type hints: required on all public functions
- Docstrings: Google style
- Max line length: 88 (black default)

### JavaScript / TypeScript
- Formatter: **prettier** (`npx prettier --write .`)
- Linter: **eslint** (`npx eslint .`)
- Always use TypeScript over plain JavaScript for new files
- Prefer `const` over `let`; never use `var`
- Use named exports over default exports for modules

### Shell / Bash
- Lint with: **shellcheck** (`shellcheck script.sh`)
- Always include `set -euo pipefail` at the top of scripts
- Quote all variable expansions: `"$VAR"` not `$VAR`
- Use `#!/usr/bin/env bash` as the shebang

### General
- Trailing newline at end of every file
- No trailing whitespace
- UTF-8 encoding throughout

---

## Git & Repo Rules

### Branch Naming
```
feature/<short-description>     # new functionality
fix/<short-description>         # bug fixes
chore/<short-description>       # maintenance, deps, config
docs/<short-description>        # documentation only
refactor/<short-description>    # code restructure, no behavior change
```

### Commit Message Format (Conventional Commits)
```
<type>(<optional-scope>): <short summary>

<optional body — explain WHY, not WHAT>

<optional footer — breaking changes, issue refs>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `ci`

Examples:
```
feat(auth): add JWT refresh token support
fix(api): handle empty response from upstream service
chore: upgrade dependencies to latest patch versions
```

### Pull Request Flow
1. Branch off `main`
2. Make focused, atomic commits
3. Push branch and open PR
4. PR title should match the commit message format
5. Squash merge or rebase merge — never a merge commit

---

## Frequently Used Commands

<!-- TODO: Update these with the actual commands for this project -->

### Python Projects
```bash
# Install dependencies
pip install -r requirements.txt
# or
pip install -e ".[dev]"

# Run the app
python -m src.main

# Run tests
pytest

# Lint and format
ruff check .
black .
```

### JavaScript / TypeScript Projects
```bash
# Install dependencies
npm install

# Run dev server
npm run dev

# Run tests
npm test

# Lint and format
npm run lint
npx prettier --write .

# Build
npm run build
```

### Shell Scripts
```bash
# Check a script
shellcheck script.sh

# Run a script
bash script.sh
```

### Git Shortcuts
```bash
git status
git log --oneline --graph --decorate -20
git diff HEAD
```

---

## Testing & Build Instructions

<!-- TODO: Fill in project-specific instructions -->

### Running Tests

```bash
# Python
pytest tests/ -v

# JavaScript / TypeScript
npm test
# or
npx vitest
# or
npx jest
```

### Building for Production

```bash
# Python (packaging)
python -m build

# Node.js
npm run build
```

### CI / Linting Gate

All of the following must pass before merging:
- [ ] Linter passes with no errors
- [ ] All tests pass
- [ ] No new secrets or credentials introduced
- [ ] Code has been formatted

---

## Permissions

### Claude MAY do autonomously (no confirmation needed)
- Read any file in the repository
- Run tests (`pytest`, `npm test`, `npx vitest`)
- Run linters and formatters (`ruff`, `black`, `eslint`, `prettier`, `shellcheck`)
- Run `git status`, `git log`, `git diff`
- Stage files with `git add`
- Create new branches
- Install dev dependencies listed in existing config files

### Claude MUST ask before doing
- `git commit` — always show the proposed message and wait for approval
- `git push` — always confirm the target branch and remote
- `git merge` or `git rebase` — confirm strategy and target
- Installing new packages not already in `requirements.txt` / `package.json`
- Deleting files or directories
- Modifying environment files (`.env`, `.env.local`, etc.)
- Running database migrations
- Any operation that touches infrastructure (Docker, cloud, CI config)

### Claude MUST NOT do without explicit user instruction
- Force push (`git push --force`)
- Push directly to `main` or `master`
- Commit secrets, credentials, or API keys
- Drop or truncate database tables
- Modify `.claude/settings.json` or `CLAUDE.md` unless asked
