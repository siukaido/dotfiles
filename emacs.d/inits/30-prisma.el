;;; 30-prisma.el --- Prismaスキーマファイル編集サポート -*- lexical-binding: t; -*-

;;; Commentary:
;; Prisma ORMのスキーマファイル（.prisma）編集環境
;; 保存時の自動フォーマット機能付き
;; site-lispからprisma-modeを読み込み

;;; Code:
(use-package prisma-mode
  :defer t  ; 遅延読み込み
  :mode "\\.prisma\\'"
  :load-path "~/.emacs.d/site-lisp/"
  :straight nil  ; straight.elを使わない（ローカルファイル）
  :custom
  (prisma-format-on-save t))

;;; 30-prisma.el ends here