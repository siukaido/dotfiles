;;; 20-web.el --- Web開発統合環境設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; HTML、CSS、JavaScript等のWeb開発ファイルの統合編集環境
;; 各種テンプレートエンジン（ERB、JSP、ASP、PHP等）にも対応
;; インデント設定は 20-javascript-common.el で一括管理

;;; Code:
(use-package web-mode
  :mode (("\\.phtml\\'" . web-mode)
         ("\\.tpl\\.php\\'" . web-mode)
         ("\\.[agj]sp\\'" . web-mode)
         ("\\.as[cp]x\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.djhtml\\'" . web-mode)
         ("\\.html\\'" . web-mode)
         ("\\.scss\\'" . web-mode)
         ("\\.css\\'" . web-mode)
         ("\\.ctp\\'" . web-mode))
  :config
  (set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "white")
  (set-face-attribute 'web-mode-html-tag-face nil :foreground "NavajoWhite"))

;;; 20-web.el ends here
