;; go-mode
;; global-whitespace-modeを使うときはindent-tabs-modeをnilにすること、companyが誤作動する
;; 事前に go get golang.org/x/tools/cmd/goimports しておくこと
;(let ((envs '("GOROOT" "GOPATH")))
;  (exec-path-from-shell-copy-envs envs))
(leaf go-mode
  :commands go-mode
  :ensure t
  :config
  (with-eval-after-load 'go-mode
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)))
