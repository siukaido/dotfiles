(use-package company
  :config
  (global-company-mode);
  (custom-set-variables
   ;; 1個目を自動的に補完
   '(company-auto-expand t)
   ;; ソート順
   '(company-transformers '(company-sort-by-backend-importance))
   ;; 遅延なしにすぐ表示
   '(company-idle-delay 0)
   ;; デフォルトは4
   '(company-minimum-prefix-length 2)
   ;; 候補の最後の次は先頭に戻る
   '(company-selection-wrap-around t)
   '(completion-ignore-case t)
   '(company-dabbrev-downcase nil)
   )
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-h") nil)
  )
