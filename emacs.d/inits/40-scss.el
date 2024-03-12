(use-package scss-mode
  :ensure t
  :mode (("\\.scss\\'" . scss-mode))
  :config
  (setq scss-compile-at-save nil)
  (setq css-indent-offset 2)
  )
