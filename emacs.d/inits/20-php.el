(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$"  . php-mode))
(add-to-list 'auto-mode-alist '("\\.php5$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$"  . php-mode))
(add-to-list 'auto-mode-alist '("\\.hh$"   . php-mode))

(add-hook 'php-mode-hook
  (lambda ()
    (c-set-style "pear")))
