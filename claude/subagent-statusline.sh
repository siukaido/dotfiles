#!/bin/sh
input=$(cat)

RST="$(printf '\033[0m')"
GREEN="$(printf '\033[0;32m')"
MAGENTA="$(printf '\033[0;35m')"
DIM="$(printf '\033[2m')"
TAB="$(printf '\t')"

# タスクごとに {"id": ..., "content": ...} を1行ずつ出力する
echo "$input" | jq -r '.tasks[]? | [
    .id,
    (.name // .label // .type // "agent"),
    (.model // "?"),
    (.effort // "-"),
    (.tokenCount // 0),
    (.contextWindowSize // 0)
] | @tsv' |
while IFS="$TAB" read -r id name model effort tokens ctxsize; do
    # モデルIDを短縮表示（claude- 接頭辞と日付サフィックスを除去）
    short_model=$(echo "$model" | sed -e 's/^claude-//' -e 's/-[0-9]\{8\}$//')

    # トークン数を k 単位に整形
    if [ "$tokens" -ge 1000 ] 2>/dev/null; then
        tok=$(awk -v t="$tokens" 'BEGIN{printf "%.1fk", t/1000}')
    else
        tok="$tokens"
    fi

    # コンテキスト残量（%）: contextWindowSize が取得できた場合のみ表示
    ctx=""
    if [ "$ctxsize" -gt 0 ] 2>/dev/null; then
        ctx=$(awk -v t="$tokens" -v c="$ctxsize" 'BEGIN{printf " ctx:%d%%", (1 - t/c) * 100}')
    fi

    content="${GREEN}${name}${RST} ${MAGENTA}${short_model}${RST}"
    if [ "$effort" != "-" ]; then
        content="${content} ${DIM}${effort}${RST}"
    fi
    content="${content} tok:${tok}${ctx}"

    jq -cn --arg id "$id" --arg content "$content" '{id: $id, content: $content}'
done
