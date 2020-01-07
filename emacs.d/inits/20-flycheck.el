(use-package flycheck
  :config
  ;; 利用するモード
  ;;;; 30
  (add-hook 'go-mode-hook    'flycheck-mode)
  (add-hook 'perl-mode-hook  'flycheck-mode)
  (add-hook 'php-mode-hook   'flycheck-mode)
  ;;;; 40
  (add-hook 'js2-mode-hook   'flycheck-mode)
  (add-hook 'rjsx-mode       'flycheck-mode)
  (add-hook 'scss-mode-hook  'flycheck-mode)
  ;;;; 50
  (add-hook 'json-mode-hook  'flycheck-mode)
  (add-hook 'yaml-mode-hook  'flycheck-mode)
  )