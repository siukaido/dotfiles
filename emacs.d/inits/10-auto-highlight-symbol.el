;;; auto-highlight-symbol.el -*- lexical-binding: t; -*- --- auto-highlight-symbol.el

;;; Commentary:
;; カーソルを合わせたシンボルを使用している箇所をハイライトするemacsパッケージ

;;; Code:
(use-package auto-highlight-symbol
  :config
  (global-auto-highlight-symbol-mode t)
  (ahs-set-idle-interval 0.8)
  )

;;; 10-auto-highlight-symbol.el ends here
