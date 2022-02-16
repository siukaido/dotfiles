(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-hook 'typescript-mode-hook
          (lambda ()
            (setq typescript-indent-level 2)))
