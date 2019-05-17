(add-to-list 'auto-mode-alist '(".*\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '(".*\\.jsx\\'" . rjsx-mode))

;; rjsx-modeでauto-complete-modeを有効にする
(add-to-list 'ac-modes 'rjsx-mode)
