;; go-mode
;; global-whitespace-modeを使うときはindent-tabs-modeをnilにすること、companyが誤作動する
;; 事前に go get golang.org/x/tools/cmd/goimports しておくこと
;(let ((envs '("GOROOT" "GOPATH")))
;  (exec-path-from-shell-copy-envs envs))
(use-package go-mode
  :commands go-mode
  :defer t
  ;; :init
  ;; (add-hook 'go-mode-hook (lambda()
  ;;                           (setq indent-tabs-mode nil)
  ;;                           (setq c-basic-offset 4)
  ;;                           (setq tab-width 4)
  ;;                           ))
  :config
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))