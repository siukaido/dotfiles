;;; rjsx.el -*- lexical-binding: t; -*- --- React JSX設定

;;; Commentary:
;; React/JSXファイルの編集環境設定
;; 通常のJSファイルにはjs2-modeを使用し、JSXファイルのみrjsx-modeを使用

;;; Code:
(use-package rjsx-mode
  :mode (("\\.jsx\\'" . rjsx-mode))  ; JSXファイルのみ
  :custom
  ;; インデント設定
  (indent-tabs-mode nil)           ; インデントはタブではなくスペース

  :config

  ;; 通常のJSファイルはjs2-modeを使用
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.mjs\\'" . js2-mode)))

;; js2-mode（通常のJavaScript用）の設定
(use-package js2-mode)

;;; 40-rjsx.el ends here
