(use-package rjsx-mode
  :ensure t
  :mode (("\\.js\\'" . rjsx-mode)
         ("\\.jsx\\'" . rjsx-mode))
  :config
  (setq indent-tabs-mode nil) ;;インデントはタブではなくスペース
  (setq js-indent-level 2) ;;スペースは２つ、デフォルトは4
  (setq js2-strict-trailing-comma-warning nil))
