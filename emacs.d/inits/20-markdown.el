;;; 20-markdown.el --- Markdown編集環境設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; Markdownファイルの編集とプレビュー機能
;; GitHub Flavored Markdown（GFM）モードをデフォルトで使用
;;
;; 手動対応:
;;   1. brew install pandoc

;;; Code:
(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :custom
  (markdown-command "pandoc"))

(use-package markdown-preview-mode
  :after markdown-mode
  :custom
  (markdown-preview-stylesheets
   '("https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.1.0/github-markdown.min.css")))

;;; 20-markdown.el ends here
