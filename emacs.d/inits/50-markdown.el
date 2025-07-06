;;; 50-markdown.el -*- lexical-binding: t; -*- --- Markdown編集環境設定

;;; Commentary:
;; Markdownファイルの編集とプレビュー機能
;; GitHub Flavored Markdown（GFM）モードをデフォルトで使用
;; プレビューにはpandocを使用（要事前インストール: brew install pandoc）

;;; Code:
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)

(setq auto-mode-alist (cons '("\\.md$" . gfm-mode) auto-mode-alist))
(custom-set-variables '(markdown-command "pandoc"))

;; markdown preview mode
(use-package markdown-preview-mode
  :config
  ;; https://cdnjs.com/libraries/github-markdown-css
  (setq markdown-preview-stylesheets
        (list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.1.0/github-markdown.min.css")))

;;; 50-markdown.el ends here