;;; vue-mode.el -*- lexical-binding: t; -*- --- Vue.js開発サポート

;;; Commentary:
;; Vue.jsコンポーネント開発環境（遅延読み込み）

;;; Code:
(use-package vue-mode
  :defer t  ; 遅延読み込み
  :mode "\\.vue\\'"
  :hook (vue-mode . flycheck-mode))
;;; 40-vue-mode.el ends here
