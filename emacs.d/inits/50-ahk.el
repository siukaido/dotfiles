(load-file "~/.emacs.d/site-lisp/ahk-mode.el")
(autoload 'ahk-mode "ahk-mode" "AutoHotkey mode." t)
(add-to-list 'auto-mode-alist '("\\.ahk\\'" . ahk-mode))
