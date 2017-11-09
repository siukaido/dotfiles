(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)

;; You can edit user-customizable variables by typing the following command.
;;     M-x customize-group [RET] jsx-mode
(custom-set-variables
 '(jsx-indent-level 2))
