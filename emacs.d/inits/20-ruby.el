;;; 20-ruby.el --- Ruby開発環境設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; Ruby開発環境の設定
;; マジックコメントの自動挿入は無効化

;;; Code:
(use-package ruby-mode
  :straight nil  ; 組み込みパッケージ
  :mode "\\.j?builder$"
  :config
  (setq ruby-insert-encoding-magic-comment nil))

;;; 20-ruby.el ends here
