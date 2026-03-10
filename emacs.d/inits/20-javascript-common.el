;;; 20-javascript-common.el --- JavaScript/TypeScript共通設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; JavaScript、TypeScript、JSON等の共通インデント設定
;; 各言語固有の設定ファイルより先に読み込まれる

;;; Code:
(use-package emacs
  :straight nil
  :custom
  ;; JavaScript共通のインデント設定
  (js-indent-level 2)              ; js-mode / js-ts-mode
  (json-reformat:indent-width 2)   ; JSONフォーマット

  ;; web-mode用インデント設定
  (web-mode-code-indent-offset 2)  ; web-modeのJavaScript部分
  (web-mode-css-indent-offset 2)   ; web-modeのCSS部分
  (web-mode-markup-indent-offset 2)) ; web-modeのHTML部分

;;; 20-javascript-common.el ends here
