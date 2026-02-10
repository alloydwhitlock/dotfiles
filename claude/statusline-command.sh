#!/bin/bash
input=$(cat)

# Extract values with jq
model=$(echo "$input" | jq -r '.model.display_name // "?"')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // ""')

# Colors
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
CYAN='\033[36m'
MAGENTA='\033[35m'
DIM='\033[2m'
RST='\033[0m'

# --- Cached git info (5s TTL) ---
CACHE_FILE="/tmp/statusline-git-cache"
CACHE_MAX_AGE=5

cache_is_stale() {
  [ ! -f "$CACHE_FILE" ] || \
  [ $(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0))) -gt $CACHE_MAX_AGE ]
}

if cache_is_stale; then
  if [ -n "$cwd" ] && git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
    staged=$(git -C "$cwd" diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    modified=$(git -C "$cwd" diff --numstat 2>/dev/null | wc -l | tr -d ' ')
    untracked=$(git -C "$cwd" ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
    remote=$(git -C "$cwd" remote get-url origin 2>/dev/null \
      | sed 's|git@github\.com:|https://github.com/|' \
      | sed 's|\.git$||')
    echo "${branch}|${staged}|${modified}|${untracked}|${remote}" > "$CACHE_FILE"
  else
    echo "||||" > "$CACHE_FILE"
  fi
fi

IFS='|' read -r branch staged modified untracked remote < "$CACHE_FILE"

# --- Format duration ---
total_sec=$((duration_ms / 1000))
hours=$((total_sec / 3600))
mins=$(((total_sec % 3600) / 60))
secs=$((total_sec % 60))
if [ $hours -gt 0 ]; then
  duration="${hours}h${mins}m"
elif [ $mins -gt 0 ]; then
  duration="${mins}m${secs}s"
else
  duration="${secs}s"
fi

# --- Format cost ---
if (( $(echo "$cost_usd < 0.01" | bc -l 2>/dev/null || echo 1) )); then
  cost="<\$0.01"
else
  cost="\$$(printf "%.2f" "$cost_usd")"
fi

# --- Cook emoji burn meter ---
if [ "$used_pct" -lt 15 ]; then
  cook="🥚"
elif [ "$used_pct" -lt 40 ]; then
  cook="🍳"
elif [ "$used_pct" -lt 65 ]; then
  cook="🍲"
elif [ "$used_pct" -lt 85 ]; then
  cook="🔥🍲"
else
  cook="🔥💀"
fi

# --- Progress bar (15 chars) ---
bar_w=15
filled=$((used_pct * bar_w / 100))
empty=$((bar_w - filled))

if [ "$used_pct" -lt 50 ]; then
  bar_clr="$GREEN"
elif [ "$used_pct" -lt 75 ]; then
  bar_clr="$YELLOW"
else
  bar_clr="$RED"
fi

bar=""
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty; i++)); do bar+="░"; done

# --- Line 1: Git info + clickable repo link ---
if [ -n "$branch" ]; then
  git_status=""
  [ "$staged" -gt 0 ] 2>/dev/null && git_status="${GREEN}+${staged}${RST}"
  [ "$modified" -gt 0 ] 2>/dev/null && git_status="${git_status} ${YELLOW}~${modified}${RST}"
  [ "$untracked" -gt 0 ] 2>/dev/null && git_status="${git_status} ${DIM}?${untracked}${RST}"

  repo_link=""
  if [ -n "$remote" ]; then
    repo_name=$(basename "$remote")
    # OSC 8 clickable link
    repo_link=" ${DIM}|${RST} \e]8;;${remote}\a${CYAN}${repo_name}${RST}\e]8;;\a"
  fi

  printf '%b' "${GREEN}🌿 ${branch}${RST} ${git_status}${repo_link}\n"
fi

# --- Line 2: Burn meter + context bar + stats ---
printf '%b' "${cook} ${bar_clr}[${bar}]${used_pct}%${RST}  ${MAGENTA}${model}${RST}  ${CYAN}⏱ ${duration}${RST}  ${YELLOW}💰 ${cost}${RST}\n"
