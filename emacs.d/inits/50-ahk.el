;;; 50-ahk.el -*- lexical-binding: t; -*- --- AutoHotkey編集サポート

;;; Commentary:
;; AutoHotkeyスクリプト編集環境（遅延読み込み）
;; site-lispからahk-modeを読み込み

;;; Code:
(use-package ahk-mode
  :defer t  ; 遅延読み込み
  :mode "\\.ahk\\'"
  :load-path "~/.emacs.d/site-lisp/"
  :straight nil)  ; straight.elを使わない（ローカルファイル）

;;; 50-ahk.el ends here