;;; 30-ahk.el --- AutoHotkey編集サポート -*- lexical-binding: t; -*-

;;; Commentary:
;; AutoHotkeyスクリプト編集環境（遅延読み込み）
;; site-lispからahk-modeを読み込み
;; Windows環境で使用

;;; Code:
(use-package ahk-mode
  :defer t  ; 遅延読み込み
  :mode "\\.ahk\\'"
  :load-path "~/.emacs.d/site-lisp/"
  :straight nil)  ; straight.elを使わない（ローカルファイル）

;;; 30-ahk.el ends here
