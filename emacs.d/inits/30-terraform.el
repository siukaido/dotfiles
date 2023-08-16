(use-package terraform-mode
  :ensure t
  :mode "\\.tf\\'"
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))
