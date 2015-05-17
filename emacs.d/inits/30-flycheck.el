;; 利用するモード
(add-hook 'js2-mode-hook   'flycheck-mode)
(add-hook 'json-mode-hook  'flycheck-mode)
(add-hook 'perl-mode-hook  'flycheck-mode)
(add-hook 'php-mode-hook   'flycheck-mode)
(add-hook 'scala-mode-hook 'flycheck-mode)
(add-hook 'scss-mode-hook  'flycheck-mode)
(add-hook 'yaml-mode-hook  'flycheck-mode)

;; エラー情報をTIP表示する
(setq flycheck-highlighting-mode 'lines)
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))
