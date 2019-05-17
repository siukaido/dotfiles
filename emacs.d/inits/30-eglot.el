;; eglot
;; M-.で定義ジャンプ、M-,でジャンプ先からもどる
;; eglot はデフォルトの Language Server として go-langserver を使うので gopls に変更する
;; 事前に go get -u golang.org/x/tools/cmd/gopls しておくこと
(use-package eglot
  :config
  (add-to-list 'eglot-server-programs '(go-mode . ("gopls")))
  (add-hook 'go-mode-hook 'eglot-ensure)
  ;; keybind change
  (define-key eglot-mode-map (kbd "M-.") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "M-,") 'pop-tag-mark)
)
