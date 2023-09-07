(load-file "~/.emacs.d/site-lisp/prisma-mode.el")
(autoload 'prisma-mode "prisma-mode" nil t)
(setq prisma-format-on-save t)
(add-to-list 'auto-mode-alist '("\\.prisma\\'" . prisma-mode))
