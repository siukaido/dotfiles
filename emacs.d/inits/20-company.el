(use-package company
  :config
  (global-company-mode);
  (custom-set-variables
   '(company-auto-expand t)
   '(company-transformers '(company-sort-by-backend-importance))
   '(company-idle-delay 0)
   '(company-minimum-prefix-length 2)
   '(company-selection-wrap-around t)
   '(completion-ignore-case t)
   '(company-dabbrev-downcase nil)
   '(company-go-insert-arguments nil)
   )
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-h") nil)
  )
