;;; 50-json.el --- json mode

;;; Commentary:

;;; Code:
(use-package json-mode
  :ensure t
  :config
  (setq js-indent-level 2))
(add-to-list 'auto-mode-alist '("\\.jsonc$" . jsonc-mode))
;;; 50-json.el ends here
