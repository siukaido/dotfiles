(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.ya?ml\\.liquid$" . yaml-mode))
  (define-key yaml-mode-map "\C-m" 'newline-and-indent))
