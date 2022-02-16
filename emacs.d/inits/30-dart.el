(use-package dart-mode
  :init
  (add-hook 'dart-mode-hook
            (lambda ()
              (setq dart-enable-analysis-server t)
              (setq dart-format-on-save t))))
