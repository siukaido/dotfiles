;;; atom-dark-theme.el --- Atom Dark theme -*- lexical-binding: t; -*-

;;; Commentary:
;; カラーテーマの設定

;;; Code
;; https://github.com/whitlockjc/atom-dark-theme-emacs
(use-package atom-dark-theme
  :init
  (load-theme 'atom-dark t)
  :config
  ;; カスタマイズが必要な場合はここに追加
  (custom-set-faces
   '(which-func ((t (:foreground "#96CBFE" :weight bold)))))
  )

;;; 10-color-theme.el ends here
