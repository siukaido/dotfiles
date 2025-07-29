;;; 30-ruby.el -*- lexical-binding: t; -*- --- Ruby開発環境設定

;;; Commentary:
;; Ruby開発環境の設定
;; RuboCopによるコード検証を有効化
;; マジックコメントの自動挿入は無効化

;;; Code:
(use-package ruby-mode
  :straight nil  ; 組み込みパッケージ
  :mode "\\.j?builder$"
  :config
  (setq ruby-insert-encoding-magic-comment nil))

;;; 30-ruby.el ends here
