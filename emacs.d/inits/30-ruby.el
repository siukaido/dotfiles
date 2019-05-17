(use-package ruby-mode)
(setq ruby-insert-encoding-magic-comment nil)
(add-hook 'ruby-mode-hook
          (lambda ()
            (setq flycheck-checker 'ruby-rubocop)
            (flycheck-mode 1)
            ))
