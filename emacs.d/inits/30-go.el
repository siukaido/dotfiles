;;; 30-go.el -*- lexical-binding: t; -*- --- Go言語開発環境設定

;;; Commentary:
;; Go言語の開発環境設定
;; goimportsによる自動フォーマット、company-goによる補完機能
;; 事前に go get golang.org/x/tools/cmd/goimports しておくこと
;; global-whitespace-modeを使うときはindent-tabs-modeをnilにすること、companyが誤作動する

;;; Code:
;(let ((envs '("GOROOT" "GOPATH")))
;  (exec-path-from-shell-copy-envs envs))
(use-package company-go)
(use-package go-mode
  :init
  :config
  (with-eval-after-load 'go-mode
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)
    (add-to-list 'company-backends 'company-go)))

(use-package go-eldoc
  :init
  :config
  (with-eval-after-load 'go-mode
    (add-hook 'go-mode-hook 'go-eldoc-setup)
    (set-face-attribute 'eldoc-highlight-function-argument nil
                        :underline t :foreground "green"
                        :weight 'bold)
    ))

;;; 30-go.el ends here