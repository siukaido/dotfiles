;;; auto-highlight-symbol.el --- auto-highlight-symbol.el

;;; Commentary:
;; カーソルを合わせたシンボルを使用している箇所をハイライトするemacsパッケージ

;;; Code:
(use-package auto-highlight-symbol
  :ensure t
  :config
  (global-auto-highlight-symbol-mode t)
  (ahs-set-idle-interval 0.8)
  )
