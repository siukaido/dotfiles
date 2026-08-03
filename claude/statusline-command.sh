#!/bin/sh
input=$(cat)

# モデル名
model=$(echo "$input" | jq -r '.model.display_name // "?"')

# 作業ディレクトリ（ホームを ~ に短縮）
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
display_dir=$(echo "$cwd" | sed "s|^$HOME|~|")

# コンテキスト使用量（%）
ctx_used=$(echo "$input" | jq -r '.context_window.used_percentage // "-"' | cut -d. -f1)

# レート制限（5時間 / 7日）
rate_5h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // "-"' | cut -d. -f1)
rate_7d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // "-"' | cut -d. -f1)

# レート制限の残量に応じた色を返す（残量20%未満→オレンジ、10%未満→赤）
rate_color() {
    val="$1"
    if [ "$val" = "-" ]; then
        return
    elif [ "$val" -ge 90 ] 2>/dev/null; then
        printf "\033[0;31m"
    elif [ "$val" -ge 80 ] 2>/dev/null; then
        printf "\033[0;33m"
    fi
}

RST="\033[0m"
printf "\033[0;35m%s${RST} \033[0;32m%s${RST} %sctx:%s%%${RST} %s5h:%s%%${RST} %s7d:%s%%${RST}" \
       "$model" "$display_dir" "$(rate_color "$ctx_used")" "$ctx_used" "$(rate_color "$rate_5h")" "$rate_5h" "$(rate_color "$rate_7d")" "$rate_7d"
