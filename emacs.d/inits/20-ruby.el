;; ruby-mode
(require 'ruby-mode)
(setq ruby-insert-encoding-magic-comment nil)
(add-hook 'ruby-mode-hook
          (lambda ()
            (setq flycheck-checker 'ruby-rubocop)
            (setq flycheck-ruby-rubocop-executable "~/.rbenv/shims/rubocop")
            (flycheck-mode 1)))
