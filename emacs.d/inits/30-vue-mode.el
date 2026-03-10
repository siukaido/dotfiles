;;; 30-vue-mode.el --- Vue.js開発サポート -*- lexical-binding: t; -*-

;;; Commentary:
;; Vue.jsコンポーネント開発環境（遅延読み込み）

;;; Code:
;; flycheck は global-flycheck-mode で有効化済み
(use-package vue-mode
  :defer t  ; 遅延読み込み
  :mode "\\.vue\\'")
;;; 30-vue-mode.el ends here
