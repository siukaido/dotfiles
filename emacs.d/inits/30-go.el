;; go-mode
;; global-whitespace-modeを使うときはindent-tabs-modeをnilにすること、companyが誤作動する
;; 事前に go get golang.org/x/tools/cmd/goimports しておくこと
;(let ((envs '("GOROOT" "GOPATH")))
;  (exec-path-from-shell-copy-envs envs))
(use-package go-mode
  :init
  :config
  (with-eval-after-load 'go-mode
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)
    (add-to-list 'company-backends 'company-go)))
(add-hook 'go-mode-hook 'go-eldoc-setup)
