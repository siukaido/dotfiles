(add-to-list 'auto-mode-alist '(".*\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '(".*\\.jsx\\'" . rjsx-mode))
(add-hook 'rjsx-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil) ;;インデントはタブではなくスペース
            (setq js-indent-level 2) ;;スペースは２つ、デフォルトは4
            (setq js2-strict-trailing-comma-warning nil)))
