#!/usr/bin/env bash
set -u

input="$(cat)"

model="$(printf '%s' "$input" | jq -r '.model.display_name // "Claude"')"
dir="$(printf '%s' "$input" | jq -r '(.workspace.current_dir // .cwd // "") | split("/") | last')"

used_pct="$(printf '%s' "$input" | jq -r '.context_window.used_percentage // empty')"
used_tok="$(printf '%s' "$input" | jq -r '.context_window.total_input_tokens // 0')"
limit_tok="$(printf '%s' "$input" | jq -r '.context_window.context_window_size // 0')"

ctx=""
if [ -n "$used_pct" ]; then
  ctx="$(awk -v p="$used_pct" -v u="$used_tok" -v l="$limit_tok" 'BEGIN{
    pct = sprintf("%.0f", p);
    if (u >= 1000) { us = sprintf("%dk", int(u/1000)) } else { us = u };
    if (l >= 1000) { ls = sprintf("%dk", int(l/1000)) } else { ls = l };
    color = "\033[2m";              # dim (default)
    if (pct+0 >= 80) { color = "\033[31m" }        # red
    else if (pct+0 >= 50) { color = "\033[33m" };  # yellow
    printf "%s%s%% (%s/%s)\033[0m", color, pct, us, ls;
  }')"
fi

if [ -n "$ctx" ]; then
  printf "\033[2m%s\033[0m \033[2min\033[0m \033[2m%s\033[0m \033[2m|\033[0m Ctx: %s\n" "$model" "$dir" "$ctx"
else
  printf "\033[2m%s\033[0m \033[2min\033[0m \033[2m%s\033[0m\n" "$model" "$dir"
fi
