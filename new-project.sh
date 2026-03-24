#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# new-project.sh — scaffold a new project from this Claude Code template
#
# Usage:
#   ./new-project.sh <project-name> [target-directory]
#   ./new-project.sh --github <project-name> [target-directory]
#
# Arguments:
#   project-name       Required. Name of the new project (used as directory name)
#   target-directory   Optional. Where to create the project. Defaults to the
#                      parent of this template repo (i.e. sibling directory).
#
# Flags:
#   --github           Clone from GitHub instead of copying local template files.
#                      Use this when running the script from outside the template repo.
#
# Examples:
#   ./new-project.sh my-api
#   ./new-project.sh my-cli ~/dev/personal
#   new-project.sh --github my-api ~/dev/projects
# ---------------------------------------------------------------------------

GITHUB_TEMPLATE="https://github.com/Odwiys/claude-code-template"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR"
USE_GITHUB=false

# ---- Flag parsing ----------------------------------------------------------

if [[ "${1:-}" == "--github" ]]; then
  USE_GITHUB=true
  shift
fi

# ---- Argument validation ---------------------------------------------------

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 [--github] <project-name> [target-directory]" >&2
  echo ""
  echo "Example: $0 my-api"
  echo "Example: $0 my-api ~/dev/projects"
  echo "Example: $0 --github my-api ~/dev/projects"
  exit 1
fi

PROJECT_NAME="$1"
TARGET_PARENT="${2:-$(dirname "$TEMPLATE_DIR")}"
DEST="$TARGET_PARENT/$PROJECT_NAME"

# Validate project name (alphanumeric, hyphens, underscores only)
if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo "Error: project name must contain only letters, numbers, hyphens, and underscores." >&2
  exit 1
fi

if [[ -e "$DEST" ]]; then
  echo "Error: '$DEST' already exists. Choose a different name or target directory." >&2
  exit 1
fi

# ---- Scaffold --------------------------------------------------------------

echo "Creating project: $PROJECT_NAME"
echo "Location:         $DEST"
echo ""

if [[ "$USE_GITHUB" == true ]]; then
  # ---- GitHub clone path ---------------------------------------------------
  echo "Source:           $GITHUB_TEMPLATE"
  echo ""
  git clone --quiet "$GITHUB_TEMPLATE" "$DEST"
  rm -rf "$DEST/.git"
  git -C "$DEST" init --quiet
  git -C "$DEST" add CLAUDE.md .gitignore .mcp.json .claude/
  git -C "$DEST" commit --quiet -m "chore: initial project scaffold from claude-code-template"
else
  # ---- Local copy path -----------------------------------------------------
  mkdir -p "$DEST"
  cp "$TEMPLATE_DIR/CLAUDE.md"  "$DEST/CLAUDE.md"
  cp "$TEMPLATE_DIR/.gitignore" "$DEST/.gitignore"
  cp "$TEMPLATE_DIR/.mcp.json"  "$DEST/.mcp.json"
  cp -r "$TEMPLATE_DIR/.claude" "$DEST/.claude"
  git -C "$DEST" init --quiet
  git -C "$DEST" add CLAUDE.md .gitignore .mcp.json .claude/
  git -C "$DEST" commit --quiet -m "chore: initial project scaffold from claude-code-template"
fi

# ---- Success message -------------------------------------------------------

echo "Project scaffold complete."
echo ""
echo "Next steps:"
echo "  1.  cd $DEST"
echo "  2.  Open CLAUDE.md and fill in the Project Overview and Architecture sections."
echo "  3.  Update the Frequently Used Commands section for your stack."
echo "  4.  Add your source files and start building."
echo ""
echo "Happy building!"
