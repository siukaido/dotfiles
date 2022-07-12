(use-package vue-mode
  :init
  (add-hook 'vue-mode-hook (lambda()
                             (flycheck-mode 1)
                             )))
