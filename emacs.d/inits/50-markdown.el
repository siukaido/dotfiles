;; MEMO: コンバータとして pandoc を使っているので、前もって brew install pandoc をしておく必要がある

(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)

(setq auto-mode-alist (cons '("\\.md$" . gfm-mode) auto-mode-alist))
(custom-set-variables '(markdown-command "pandoc"))

; markdown preview mode
(use-package markdown-preview-mode
  :config
  ;; https://cdnjs.com/libraries/github-markdown-css
  (setq markdown-preview-stylesheets
        (list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.1.0/github-markdown.min.css")))
