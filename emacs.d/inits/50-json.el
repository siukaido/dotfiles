;;; 50-json.el --- json mode

;;; Commentary:

;;; Code:
(use-package json-mode
  :ensure t
  :mode "\\.json$"
  :config
  (setq json-reformat:indent-width 2)
  (setq json-reformat:pretty-string? t)
  (setq tab-width 2)
  (make-local-variable 'js-indent-level)
  (setq js-indent-level 2))
;;; 50-json.el ends here
