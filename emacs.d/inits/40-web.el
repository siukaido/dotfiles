;;; 40-web.el -*- lexical-binding: t; -*- --- Web開発統合環境設定

;;; Commentary:
;; HTML、CSS、JavaScript等のWeb開発ファイルの統合編集環境
;; 各種テンプレートエンジン（ERB、JSP、ASP、PHP等）にも対応
;; インデント幅は2スペースに統一

;;; Code:
(use-package web-mode
  :init
  (add-hook 'web-mode-hook (lambda()
                             (setq indent-tabs-mode nil)
                             (setq web-mode-markup-indent-offset 2)
                             (setq web-mode-css-indent-offset 2)
                             (setq web-mode-code-indent-offset 2)
                             (setq tab-width 2)
                             (flycheck-mode 1)))
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ctp\\'" . web-mode)))
(set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "white")
(set-face-attribute 'web-mode-html-tag-face nil :foreground "NavajoWhite")

;;; 40-web.el ends here