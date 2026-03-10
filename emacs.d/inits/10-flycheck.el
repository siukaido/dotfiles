;;; 10-flycheck.el --- シンタックスチェックの設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; flycheck によるリアルタイムシンタックスチェックの設定
;; 各言語の LSP サーバーやリンターと連携

;;; Code:
(use-package flycheck
  :init
  (global-flycheck-mode 1)
  :custom
  (flycheck-check-syntax-automatically '(save mode-enabled))
  (flycheck-idle-change-delay 0.5)
  (flycheck-display-errors-delay 0.5)
  (flycheck-indication-mode 'left-fringe)
  (flycheck-highlighting-mode 'symbols)
  :config
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'vue-mode)

  (setq-default flycheck-disabled-checkers
                '(emacs-lisp-checkdoc
                  json-jsonlint
                  javascript-jshint)))

;;; エラーはエコーエリア（ミニバッファ行）にカーソル合わせ時に表示

;;; 10-flycheck.el ends here
