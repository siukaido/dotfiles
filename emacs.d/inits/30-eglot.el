;; eglot
;; M-.で定義ジャンプ、M-,でジャンプ先からもどる
;; eglot はデフォルトの Language Server として go-langserver を使うので golsp に変更する
;; 事前に go get -u golang.org/x/tools/cmd/gopls しておくこと
(use-package eglot
  :config
  (define-key eglot-mode-map (kbd "M-.") 'xref-find-definitions)
  (define-key eglot-mode-map (kbd "M-,") 'pop-tag-mark)
  (add-to-list 'eglot-server-programs '(go-mode . ("gopls")))
  (add-hook 'go-mode-hook 'eglot-ensure))
