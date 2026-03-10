;;; 20-go.el --- Go言語開発環境設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; Go言語の開発環境設定
;; goimports による自動フォーマット、eglot + gopls による補完・型情報
;;
;; 手動対応:
;;   1. go install golang.org/x/tools/cmd/goimports@latest
;;   2. go install golang.org/x/tools/gopls@latest

;;; Code:
(use-package go-mode
  :mode "\\.go\\'"
  :hook ((go-mode . eglot-ensure)
         (go-mode . (lambda ()
                      (setq-local gofmt-command "goimports")
                      (add-hook 'before-save-hook #'gofmt-before-save nil t)))))

;;; 20-go.el ends here
