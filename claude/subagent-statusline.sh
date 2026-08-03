#!/bin/sh
input=$(cat)

# マルチバイト文字（日本語）の文字数を正しく数えるためのロケール設定
export LC_ALL=en_US.UTF-8

RST="$(printf '\033[0m')"
GREEN="$(printf '\033[0;32m')"
MAGENTA="$(printf '\033[0;35m')"
DIM="$(printf '\033[2m')"
TAB="$(printf '\t')"

# UI が content の描画に使える幅（端末幅から行頭のアイコン等プレフィックス幅を引いた値）
columns=$(echo "$input" | jq -r '.columns // 0')

# 文字列の表示幅を概算する（ASCII=1桁、CJK 3バイト文字=2桁 → (バイト数+文字数)/2）
display_width() {
    b=$(printf '%s' "$1" | wc -c)
    c=$(printf '%s' "$1" | wc -m)
    echo $(( (b + c) / 2 ))
}

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

    # コンテキスト使用量（%）: contextWindowSize が取得できた場合のみ表示
    ctx=""
    if [ "$ctxsize" -gt 0 ] 2>/dev/null; then
        ctx=$(awk -v t="$tokens" -v c="$ctxsize" 'BEGIN{printf " ctx:%d%%", t/c * 100}')
    fi

    left="${GREEN}${name}${RST} ${MAGENTA}${short_model}${RST}"
    left_plain="${name} ${short_model}"
    if [ "$effort" != "-" ]; then
        left="${left} ${DIM}${effort}${RST}"
        left_plain="${left_plain} ${effort}"
    fi
    right="tok:${tok}${ctx}"

    # メトリクスを行の右端に寄せる（columns が取れない場合はインライン表示にフォールバック）
    if [ "$columns" -gt 0 ] 2>/dev/null; then
        pad=$(( columns - $(display_width "$left_plain") - $(display_width "$right") ))
        [ "$pad" -lt 1 ] && pad=1
        content="${left}$(printf "%${pad}s" "")${right}"
    else
        content="${left} ${right}"
    fi

    jq -cn --arg id "$id" --arg content "$content" '{id: $id, content: $content}'
done
