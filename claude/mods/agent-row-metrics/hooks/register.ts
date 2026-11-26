import type { Register } from 'claude-code'

const RST = '\x1b[0m'
const GREEN = '\x1b[0;32m'
const MAGENTA = '\x1b[0;35m'
const DIM = '\x1b[2m'

/** 文字列の表示幅（全角・CJK は 2 桁、それ以外は 1 桁）を数える */
function displayWidth(text: string): number {
  let width = 0
  for (const ch of text) {
    const code = ch.codePointAt(0) ?? 0
    const wide =
      (code >= 0x1100 && code <= 0x115f) ||
      (code >= 0x2e80 && code <= 0xa4cf) ||
      (code >= 0xac00 && code <= 0xd7a3) ||
      (code >= 0xf900 && code <= 0xfaff) ||
      (code >= 0xfe30 && code <= 0xfe4f) ||
      (code >= 0xff00 && code <= 0xff60) ||
      (code >= 0xffe0 && code <= 0xffe6) ||
      code >= 0x1f300
    width += wide ? 2 : 1
  }
  return width
}

/** モデル ID を短くする（claude- の接頭辞と日付の接尾辞を外す） */
function shortModel(model: string | undefined): string {
  if (!model) return '?'
  return model.replace(/^claude-/, '').replace(/-\d{8}$/, '')
}

/** トークン数を k 単位に整える */
function formatTokens(tokens: number): string {
  return tokens >= 1000 ? `${(tokens / 1000).toFixed(1)}k` : String(tokens)
}

/**
 * サブエージェントの行の本文を、左に名前・モデル・effort、右端にトークン数とコンテキスト使用率で描く
 * （~/.claude/subagent-statusline.sh と同じ表示）
 */
export const register: Register = (on) => {
  on('ui.render', { component: 'AgentRow' }, ($, e, next) => {
    const agent = e.props
    const name = agent.name || agent.label || agent.type || 'agent'
    const model = shortModel(agent.model)
    const effort = agent.effort === undefined ? undefined : String(agent.effort)

    let left = `${GREEN}${name}${RST} ${MAGENTA}${model}${RST}`
    let leftPlain = `${name} ${model}`
    if (effort) {
      left += ` ${DIM}${effort}${RST}`
      leftPlain += ` ${effort}`
    }

    const ctx =
      agent.contextWindowSize && agent.contextWindowSize > 0
        ? ` ctx:${Math.floor((agent.tokenCount / agent.contextWindowSize) * 100)}%`
        : ''
    const right = `tok:${formatTokens(agent.tokenCount)}${ctx}`

    const columns = agent.columns ?? 0
    const body =
      columns > 0
        ? `${left}${' '.repeat(Math.max(1, columns - displayWidth(leftPlain) - displayWidth(right)))}${right}`
        : `${left} ${right}`

    return next({ ...e, props: { ...agent, body } })
  })
}
